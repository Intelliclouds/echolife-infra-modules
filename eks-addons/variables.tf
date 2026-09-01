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
# Cluster
##########################################

variable "cluster_name" {
  type = string
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
