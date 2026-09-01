##########################################
# EKS Cluster Outputs
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
  description = "EKS Cluster API Server Endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes Version"
  value       = aws_eks_cluster.this.version
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded cluster CA certificate"
  value       = aws_eks_cluster.this.certificate_authority[0].data
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
# Node Group Outputs
##########################################

output "node_group_name" {
  description = "EKS Managed Node Group Name"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "EKS Managed Node Group ARN"
  value       = aws_eks_node_group.this.arn
}

##########################################
# IAM Outputs
##########################################

output "cluster_role_arn" {
  description = "EKS Cluster IAM Role ARN"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  description = "EKS Node IAM Role ARN"
  value       = aws_iam_role.eks_node_role.arn
}
