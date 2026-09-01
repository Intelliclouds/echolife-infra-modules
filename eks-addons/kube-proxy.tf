##########################################
# kube-proxy
##########################################

resource "aws_eks_addon" "kube_proxy" {

  cluster_name = var.cluster_name

  addon_name = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi_policy
  ]
}
