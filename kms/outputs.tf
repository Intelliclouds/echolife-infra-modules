output "eks_key_arn" {
  value       = aws_kms_key.eks.arn
  description = "ARN of the EKS KMS key"
}

output "rds_key_arn" {
  value       = aws_kms_key.rds.arn
  description = "ARN of the RDS KMS key"
}

output "secrets_key_arn" {
  value       = aws_kms_key.secrets.arn
  description = "ARN of the Secrets Manager KMS key"
}
