variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "The base CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "public_subnets" {
  description = "List of CIDR blocks for Public Edge subnets (/24)"
  type        = list(string)
}

variable "private_app_subnets" {
  description = "List of CIDR blocks for Private App subnets (/19)"
  type        = list(string)
}

variable "private_data_subnets" {
  description = "List of CIDR blocks for Private Data subnets (/22)"
  type        = list(string)
}
