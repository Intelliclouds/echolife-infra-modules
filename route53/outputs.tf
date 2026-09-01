output "hosted_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = var.create_zone ? aws_route53_zone.main[0].zone_id : null
}

output "name_servers" {
  description = "Route 53 name servers"
  value       = var.create_zone ? aws_route53_zone.main[0].name_servers : []
}

output "domain_name" {
  description = "Domain name"
  value       = var.domain_name
}
