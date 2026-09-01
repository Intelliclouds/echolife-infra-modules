##########################################
# CoreDNS
##########################################

resource "aws_eks_addon" "coredns" {

  cluster_name = aws_eks_cluster.this.name

  addon_name = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_eks_node_group.this
  ]
}

##########################################
# kube-proxy
##########################################

resource "aws_eks_addon" "kube_proxy" {

  cluster_name = aws_eks_cluster.this.name

  addon_name = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_eks_node_group.this
  ]
}

##########################################
# Amazon VPC CNI
##########################################

resource "aws_eks_addon" "vpc_cni" {

  cluster_name = aws_eks_cluster.this.name

  addon_name = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_eks_node_group.this
  ]
}

##########################################
# EKS Add-On: EBS CSI Driver
##########################################

resource "aws_eks_addon" "ebs_csi" {
  cluster_name             = aws_eks_cluster.this.name
  addon_name               = "aws-ebs-csi-driver"
  
  # Attach the IAM Role we just created
  service_account_role_arn = aws_iam_role.ebs_csi_role.arn

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-ebs-csi-addon"
    }
  )

  # CRITICAL: Do not deploy the add-on until nodes are ready to host the pods
  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi_policy,
    aws_eks_node_group.this 
  ]
}
