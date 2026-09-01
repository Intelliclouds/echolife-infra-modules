##########################################
# EKS Managed Node Group
##########################################

resource "aws_eks_node_group" "this" {

  cluster_name    = var.cluster_name

  node_group_name = var.node_group_name

  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = var.private_subnet_ids

  ##########################################
  # Capacity
  ##########################################

  capacity_type  = var.capacity_type

  instance_types = var.instance_types

  ##########################################
  # Scaling
  ##########################################

  scaling_config {

    desired_size = var.desired_size

    min_size = var.min_size

    max_size = var.max_size

  }

  ##########################################
  # Rolling Updates
  ##########################################

  update_config {

    max_unavailable = 1

  }

  ##########################################
  # Labels
  ##########################################

  labels = {

    environment = var.environment

    nodegroup = var.node_group_name

  }

  ##########################################
  # Tags
  ##########################################

  tags = merge(
    var.tags,
    {
      Name = var.node_group_name
    }
  )

  ##########################################
  # Dependencies
  ##########################################

  depends_on = [

    aws_iam_role_policy_attachment.worker_node_policy,

    aws_iam_role_policy_attachment.ecr_pull_policy,

    aws_iam_role_policy_attachment.cni_policy,

    aws_iam_role_policy_attachment.ssm_policy

  ]

}
