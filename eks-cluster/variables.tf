##########################################
# Project
##########################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

##########################################
# AWS
##########################################

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

##########################################
# Cluster
##########################################

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes Version"
  type        = string
}

##########################################
# Networking
##########################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Application Subnets"
  type        = list(string)
}

##########################################
# Logging
##########################################

variable "cluster_log_types" {

  type = list(string)

  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}

##########################################
# Endpoint Access
##########################################

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

##########################################
# Tags
##########################################

variable "tags" {
  type    = map(string)
  default = {}
}
