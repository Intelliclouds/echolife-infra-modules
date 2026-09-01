##########################################
# EKS Managed Node Group
##########################################

resource "aws_eks_node_group" "this" {

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = var.private_subnet_ids

  instance_types = var.instance_types
  capacity_type  = var.capacity_type

  scaling_config {

    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size

  }

  update_config {

    max_unavailable = 1

  }

  labels = {

    environment = var.environment

  }

  tags = merge(
    var.tags,
    {
      Name = var.node_group_name
    }
  )

  depends_on = [

    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.ecr_read_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_eks_cluster.this

  ]
}
