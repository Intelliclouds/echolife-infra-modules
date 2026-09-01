variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
}

variable "allocated_storage" {
  description = "Initial storage size (GB)"
  type        = number
}

variable "secret_arn" {
  description = "Secrets Manager ARN containing database credentials"
  type        = string
}

variable "private_data_subnet_ids" {
  description = "Private database subnet IDs"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Security Groups allowed to access PostgreSQL"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "databases" {
  description = "Logical PostgreSQL databases"
  type        = list(string)

  default = [
    "identity_db",
    "vault_db",
    "safety_db",
    "family_persona_db",
    "tenant_billing_db",
    "control_plane_db"
  ]
}
