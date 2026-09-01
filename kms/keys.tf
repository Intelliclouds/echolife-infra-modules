data "aws_caller_identity" "current" {}

# Reusable KMS key policy template allowing account root delegation
data "aws_iam_policy_document" "kms_key_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

# KMS Key for EKS Cluster & Storage Volume Encryption
resource "aws_kms_key" "eks" {
  description             = "EKS Cluster and EBS Volume Encryption Key - ${var.environment}"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_key_policy.json

  tags = {
    Name        = "echolife-${var.environment}-eks-key"
    Environment = var.environment
  }
}

# KMS Key for RDS PostgreSQL Database
resource "aws_kms_key" "rds" {
  description             = "RDS PostgreSQL Encryption Key - ${var.environment}"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_key_policy.json

  tags = {
    Name        = "echolife-${var.environment}-rds-key"
    Environment = var.environment
  }
}

# KMS Key for Secrets Manager
resource "aws_kms_key" "secrets" {
  description             = "Secrets Manager Envelope Encryption Key - ${var.environment}"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_key_policy.json

  tags = {
    Name        = "echolife-${var.environment}-secrets-key"
    Environment = var.environment
  }
}
