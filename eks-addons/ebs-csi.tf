##########################################
# Amazon EBS CSI Driver
##########################################

resource "aws_eks_addon" "ebs_csi" {

  cluster_name = var.cluster_name

  addon_name = "aws-ebs-csi-driver"

  service_account_role_arn = aws_iam_role.ebs_csi_role.arn

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-ebs-csi"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi_policy
  ]
}
