variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cluster_name" {
  description = "MSK Cluster Name"
  type        = string
}

variable "kafka_version" {
  description = "Kafka Version"
  type        = string
  default     = "3.7.x"
}

variable "broker_instance_type" {
  description = "Broker Instance Type"
  type        = string
}

variable "number_of_broker_nodes" {
  description = "Broker Count"
  type        = number
}

variable "private_subnet_ids" {
  description = "Private App Subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Allowed Security Groups"
  type        = list(string)
}

variable "kms_key_alias" {
  description = "KMS Alias"
  type        = string
}
variable "ebs_volume_size" {
  description = "Broker EBS volume size (GB)"
  type        = number
  default     = 100
}
