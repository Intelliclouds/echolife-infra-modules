variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "queue_name" {
  description = "SQS queue name"
  type        = string
}

variable "fifo_queue" {
  description = "Whether this is a FIFO queue"
  type        = bool
  default     = false
}

variable "kms_key_alias" {
  description = "KMS alias used for SQS encryption"
  type        = string
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "Retention period"
  type        = number
  default     = 345600
}

variable "receive_wait_time_seconds" {
  description = "Long polling"
  type        = number
  default     = 20
}

variable "max_receive_count" {
  description = "Maximum receives before moving to DLQ"
  type        = number
  default     = 5
}
