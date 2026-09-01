data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_kms_alias" "ssm" { name = "alias/aws/ssm" }

# IAM Role & Policies
resource "aws_iam_role" "lambda_exec" {
  name = "echolife-dev-rotation-lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "lambda.amazonaws.com" } }]
  })
}

resource "aws_iam_role_policy" "lambda_ssm_access" {
  name = "ssm-kms-access"
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["ssm:GetParameter", "ssm:PutParameter"]
        Resource = "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${var.ssm_parameter_name}"
      },
      {
        Effect = "Allow"
        Action = ["kms:Decrypt", "kms:Encrypt", "kms:GenerateDataKey"]
        Resource = data.aws_kms_alias.ssm.target_key_arn
      },
      {
        Effect = "Allow"
        Action = ["ec2:CreateNetworkInterface", "ec2:DescribeNetworkInterfaces", "ec2:DeleteNetworkInterface"]
        Resource = "*"
      }
    ]
  })
}

# Network Security Group for Lambda
resource "aws_security_group" "lambda_sg" {
  name   = "echolife-dev-lambda-sg"
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# The Lambda Function
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/rotator.zip"
  
  # NEW: Prevent test scripts and virtual environments from deploying
  excludes    = ["local_test.py", "venv"]
}

resource "aws_lambda_function" "rotator" {
  function_name    = "echolife-dev-db-rotator"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "rotator.lambda_handler"
  runtime          = "python3.10"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  environment {
    variables = {
      SSM_PARAM_NAME = var.ssm_parameter_name
      DB_HOST        = var.db_host
    }
  }
}

# EventBridge Trigger (Runs every 30 days)
resource "aws_cloudwatch_event_rule" "thirty_days" {
  name                = "rotate-dev-db-password"
  schedule_expression = "rate(30 days)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.thirty_days.name
  target_id = "TriggerLambda"
  arn       = aws_lambda_function.rotator.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rotator.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.thirty_days.arn
}

# Output needed for RDS ingress rule
output "lambda_sg_id" {
  value       = aws_security_group.lambda_sg.id
  description = "Security Group ID of the rotation Lambda"
}
