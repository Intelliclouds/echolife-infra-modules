variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "create_zone" {
  description = "Whether to create the Route 53 hosted zone"
  type        = bool
  default     = true
}

variable "enable_alias_records" {
  description = "Whether to create alias records"
  type        = bool
  default     = false
}

variable "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  type        = string
  default     = ""
}

variable "alb_zone_id" {
  description = "Hosted zone ID of the Application Load Balancer"
  type        = string
  default     = ""
}

variable "records" {
  description = "Additional Route 53 DNS records"
  type = map(object({
    type    = string
    ttl     = optional(number, 300)
    records = optional(list(string), [])
  }))
  default = {}
}
