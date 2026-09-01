`##########################################
# EKS Node IAM Role
##########################################

resource "aws_iam_role" "eks_node_role" {

  name = "${var.project_name}-${var.environment}-${var.node_group_name}-node-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.node_group_name}-node-role"
    }
  )
}
##########################################
# EKS WORKER IAM Role
##########################################
resource "aws_iam_role_policy_attachment" "worker_node_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}
##########################################
# ECR Pull Policy
##########################################
resource "aws_iam_role_policy_attachment" "ecr_pull_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"

}
##########################################
# CNI Policy
##########################################
resource "aws_iam_role_policy_attachment" "cni_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}
##########################################
# SSM Policy
##########################################
resource "aws_iam_role_policy_attachment" "ssm_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}
##########################################
# CloudWatch Agent Policy
##########################################

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}
