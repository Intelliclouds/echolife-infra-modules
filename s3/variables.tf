variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "kms_key_alias" {
  description = "KMS Alias used to encrypt the bucket"
  type        = string
}

variable "bucket_name" {
  description = "Application bucket name"
  type        = string
}
