variable "project_name" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "log_retention_days" {
  type        = number
  description = "CloudWatch log retention period"
  default     = 30
}

variable "alarm_email" {
  type        = string
  description = "Email address for CloudWatch alarms"
  default     = ""
}

variable "alb_arn_suffix" {
  type        = string
  description = "ALB ARN suffix"
  default     = ""
}

variable "target_group_arn_suffix" {
  type        = string
  description = "Target group ARN suffix"
  default     = ""
}

variable "rds_instance_identifier" {
  type        = string
  description = "RDS instance identifier"
  default     = ""
}

variable "redis_replication_group_id" {
  type        = string
  description = "Redis replication group ID"
  default     = ""
}

variable "sqs_queue_name" {
  type        = string
  description = "SQS queue name"
  default     = ""
}
