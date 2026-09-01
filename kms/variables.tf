variable "environment" {
  type        = string
  description = "Environment name or scope (e.g., global, dev, prod)"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 30
  description = "Duration in days after which the key is deleted"
}
