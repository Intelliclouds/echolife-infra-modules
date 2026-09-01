##########################################
# Existing EKS Cluster
##########################################

data "aws_eks_cluster" "this" {

  name = var.cluster_name

}
