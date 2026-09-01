##########################################
# Amazon VPC CNI
##########################################

resource "aws_eks_addon" "vpc_cni" {

  cluster_name = var.cluster_name

  addon_name = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi_policy
  ]
}
