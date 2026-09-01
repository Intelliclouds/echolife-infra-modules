##########################################
# EKS Cluster IAM Role
##########################################

resource "aws_iam_role" "eks_cluster_role" {

  name = "${var.project_name}-${var.environment}-eks-cluster-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-cluster-role"
    }
  )
}

##########################################
# Amazon EKS Cluster Policy
##########################################

resource "aws_iam_role_policy_attachment" "cluster_policy" {

  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}

##########################################
# Amazon EKS VPC Resource Controller
##########################################

resource "aws_iam_role_policy_attachment" "vpc_controller" {

  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"

}
