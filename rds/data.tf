##########################################
# Read Existing Secret
##########################################

data "aws_secretsmanager_secret" "db" {
  arn = var.secret_arn
}

data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.db.id
}

##########################################
# Decode Secret JSON
##########################################

locals {
  db_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.db.secret_string
  )
}

##########################################
# Existing KMS Key
##########################################

data "aws_kms_alias" "rds" {
  name = "alias/echolife-${var.environment}-rds"
}
