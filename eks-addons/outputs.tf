##########################################
# Add-on Outputs
##########################################

output "coredns_version" {
  description = "CoreDNS Add-on Version"
  value       = aws_eks_addon.coredns.addon_version
}

output "kube_proxy_version" {
  description = "Kube Proxy Add-on Version"
  value       = aws_eks_addon.kube_proxy.addon_version
}

output "vpc_cni_version" {
  description = "VPC CNI Add-on Version"
  value       = aws_eks_addon.vpc_cni.addon_version
}

output "ebs_csi_version" {
  description = "EBS CSI Driver Version"
  value       = aws_eks_addon.ebs_csi.addon_version
}

output "ebs_csi_role_arn" {
  description = "IAM Role ARN used by EBS CSI Driver"
  value       = aws_iam_role.ebs_csi_role.arn
}
