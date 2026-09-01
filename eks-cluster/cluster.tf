##########################################
# EKS Cluster
##########################################

resource "aws_eks_cluster" "this" {

  name    = var.cluster_name
  version = var.cluster_version

  role_arn = aws_iam_role.eks_cluster_role.arn

  ##########################################
  # Networking
  ##########################################

  vpc_config {

    subnet_ids = var.private_subnet_ids

    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access

  }

  ##########################################
  # Kubernetes Secret Encryption
  ##########################################

  
  ##########################################
  # Control Plane Logging
  ##########################################

  enabled_cluster_log_types = var.cluster_log_types

  ##########################################
  # Tags
  ##########################################

  tags = merge(
    var.tags,
    {
      Name = var.cluster_name
    }
  )

  ##########################################
  # Dependencies
  ##########################################

  depends_on = [

    aws_cloudwatch_log_group.eks,

    aws_iam_role_policy_attachment.cluster_policy,

    aws_iam_role_policy_attachment.vpc_controller

  ]

}
