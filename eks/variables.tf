#######################################
# Project Configuration
#######################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

#######################################
# AWS Configuration
#######################################

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

#######################################
# EKS Cluster
#######################################

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes Version"
  type        = string
}

#######################################
# Networking
#######################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
  default     = []
}

#######################################
# Node Group
#######################################

variable "node_group_name" {
  description = "Managed Node Group Name"
  type        = string
}

variable "instance_types" {
  description = "EC2 Instance Types"
  type        = list(string)
}

variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_size" {
  description = "Desired Node Count"
  type        = number
}

variable "min_size" {
  description = "Minimum Node Count"
  type        = number
}

variable "max_size" {
  description = "Maximum Node Count"
  type        = number
}

#######################################
# Tags
#######################################

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
