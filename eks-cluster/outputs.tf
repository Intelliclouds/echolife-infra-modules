##########################################
# Cluster Outputs
##########################################

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "EKS Cluster ARN"
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes Version"
  value       = aws_eks_cluster.this.version
}

output "cluster_certificate_authority_data" {
  description = "Cluster CA Certificate"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

##########################################
# Networking Outputs
##########################################

output "cluster_security_group_id" {
  description = "Cluster Security Group"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

##########################################
# OIDC Outputs
##########################################

output "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  description = "OIDC Provider URL"
  value       = aws_iam_openid_connect_provider.eks.url
}

##########################################
# IAM Outputs
##########################################

output "cluster_role_arn" {
  description = "Cluster IAM Role ARN"
  value       = aws_iam_role.eks_cluster_role.arn
}
