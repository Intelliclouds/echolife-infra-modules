variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer to protect"
  type        = string
}
