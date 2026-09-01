##########################################
# EKS Control Plane Logs
##########################################

resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/${var.cluster_name}/cluster"

  retention_in_days = 90

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-logs"
    }
  )
}
