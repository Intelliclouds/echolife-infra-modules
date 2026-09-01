resource "aws_route53_zone" "main" {
  count = var.create_zone ? 1 : 0

  name = var.domain_name

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
