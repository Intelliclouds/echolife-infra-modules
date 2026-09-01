##########################################
# RDS Outputs
##########################################

output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "RDS Instance ARN"
  value       = aws_db_instance.this.arn
}

output "db_instance_identifier" {
  description = "RDS Instance Identifier"
  value       = aws_db_instance.this.identifier
}

output "db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "RDS Port"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Default Database Name"
  value       = aws_db_instance.this.db_name
}

output "db_subnet_group" {
  description = "DB Subnet Group"
  value       = aws_db_subnet_group.this.name
}

output "db_parameter_group" {
  description = "DB Parameter Group"
  value       = aws_db_parameter_group.this.name
}

output "kms_key_arn" {
  description = "KMS Key used by RDS"
  value       = data.aws_kms_alias.rds.target_key_arn
}
