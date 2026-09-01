resource "aws_db_parameter_group" "this" {
  name   = "echolife-${var.environment}-postgres"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  tags = {
    Environment = var.environment
  }
}
