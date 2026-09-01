##########################################
# Node Group Outputs
##########################################

output "node_group_name" {
  description = "Managed Node Group Name"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "Managed Node Group ARN"
  value       = aws_eks_node_group.this.arn
}

##########################################
# IAM Outputs
##########################################

output "node_role_arn" {
  description = "Node IAM Role ARN"
  value       = aws_iam_role.eks_node_role.arn
}

output "ebs_csi_role_arn" {
  description = "EBS CSI IAM Role ARN"
  value       = aws_iam_role.ebs_csi_role.arn
}
