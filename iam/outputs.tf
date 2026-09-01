output "eks_cluster_role_arn" {
  value       = aws_iam_role.eks_cluster.arn
  description = "ARN for the EKS Cluster role"
}

output "eks_node_role_arn" {
  value       = aws_iam_role.eks_nodes.arn
  description = "ARN for the EKS Node Group role"
}
