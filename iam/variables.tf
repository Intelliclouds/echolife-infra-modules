variable "environment" {
  type        = string
  description = "Environment name or scope"
}

variable "oidc_provider_arn" {
  type        = string
  default     = ""
  description = "ARN of EKS OIDC Provider for IRSA (empty before cluster creation)"
}

variable "oidc_provider_url" {
  type        = string
  default     = ""
  description = "URL of EKS OIDC Provider without https://"
}
