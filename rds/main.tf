##########################################
# PostgreSQL Instance
##########################################

resource "aws_db_instance" "this" {

  identifier = "echolife-${var.environment}-postgres"

  engine         = "postgres"
  engine_version = "16"
  db_name = "postgres"  

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"

  storage_encrypted = true
  kms_key_id        = data.aws_kms_alias.rds.target_key_arn

  username = local.db_credentials.username
  password = local.db_credentials.password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
  aws_security_group.rds.id
]

  publicly_accessible = false

  multi_az = var.multi_az

  backup_retention_period = var.environment == "prod" ? 35 : 7

  delete_automated_backups = false

  deletion_protection = var.environment == "prod"

  skip_final_snapshot = false

  final_snapshot_identifier = "echolife-${var.environment}-final-${formatdate("YYYYMMDDhhmmss", timestamp())}"

  parameter_group_name = aws_db_parameter_group.this.name

  performance_insights_enabled = true

  enabled_cloudwatch_logs_exports = [
    "postgresql"
  ]

  apply_immediately = true

  auto_minor_version_upgrade = true

  copy_tags_to_snapshot = true

  tags = {
    Name        = "echolife-${var.environment}-postgres"
    Environment = var.environment
  }
}
