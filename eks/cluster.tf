##########################################
# EKS Cluster
##########################################

resource "aws_eks_cluster" "this" {

  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  version = var.cluster_version

  vpc_config {

    subnet_ids = var.private_subnet_ids

    endpoint_private_access = true
    endpoint_public_access  = true

  }

  enabled_cluster_log_types = [

    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"

  ]

  tags = merge(
    var.tags,
    {
      Name = var.cluster_name
    }
  )

  depends_on = [

    aws_iam_role_policy_attachment.eks_cluster_policy

  ]
}
