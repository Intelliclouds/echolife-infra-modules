##########################################
# Project
##########################################

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

##########################################
# AWS
##########################################

variable "aws_region" {
  type = string
}

##########################################
# Existing Cluster
##########################################

variable "cluster_name" {
  type = string
}

##########################################
# Networking
##########################################

variable "private_subnet_ids" {
  type = list(string)
}

##########################################
# Node Group
##########################################

variable "node_group_name" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

##########################################
# OIDC
##########################################

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}

##########################################
# Tags
##########################################

variable "tags" {
  type    = map(string)
  default = {}
}
