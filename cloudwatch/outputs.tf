output "application_log_group_name" {
  description = "Application CloudWatch log group"
  value       = aws_cloudwatch_log_group.application.name
}

output "eks_log_group_name" {
  description = "EKS CloudWatch log group"
  value       = aws_cloudwatch_log_group.eks.name
}

output "security_log_group_name" {
  description = "Security CloudWatch log group"
  value       = aws_cloudwatch_log_group.security.name
}

output "audit_log_group_name" {
  description = "Audit CloudWatch log group"
  value       = aws_cloudwatch_log_group.audit.name
}

output "sns_topic_arn" {
  description = "CloudWatch alarm SNS topic"
  value       = aws_sns_topic.cloudwatch_alerts.arn
}

output "dashboard_name" {
  description = "CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}
