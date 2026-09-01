resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-${var.environment}"

  dashboard_body = jsonencode({
    widgets = concat(
      [
        {
          type   = "text"
          x      = 0
          y      = 0
          width  = 24
          height = 2

          properties = {
            markdown = "# EchoLife ${var.environment} Monitoring"
          }
        }
      ],

      var.alb_arn_suffix != "" ? [
        {
          type   = "metric"
          x      = 0
          y      = 2
          width  = 12
          height = 6

          properties = {
            title  = "ALB Request Count"
            region = "ap-south-1"
            period = 300
            stat   = "Sum"

            metrics = [
              [
                "AWS/ApplicationELB",
                "RequestCount",
                "LoadBalancer",
                var.alb_arn_suffix
              ]
            ]
          }
        },
        {
          type   = "metric"
          x      = 12
          y      = 2
          width  = 12
          height = 6

          properties = {
            title  = "ALB 5XX Errors"
            region = "ap-south-1"
            period = 300
            stat   = "Sum"

            metrics = [
              [
                "AWS/ApplicationELB",
                "HTTPCode_ELB_5XX_Count",
                "LoadBalancer",
                var.alb_arn_suffix
              ]
            ]
          }
        }
      ] : [],

      var.rds_instance_identifier != "" ? [
        {
          type   = "metric"
          x      = 0
          y      = 8
          width  = 12
          height = 6

          properties = {
            title  = "RDS CPU Utilization"
            region = "ap-south-1"
            period = 300
            stat   = "Average"

            metrics = [
              [
                "AWS/RDS",
                "CPUUtilization",
                "DBInstanceIdentifier",
                var.rds_instance_identifier
              ]
            ]
          }
        }
      ] : [],

      var.sqs_queue_name != "" ? [
        {
          type   = "metric"
          x      = 12
          y      = 8
          width  = 12
          height = 6

          properties = {
            title  = "SQS Messages"
            region = "ap-south-1"
            period = 300
            stat   = "Average"

            metrics = [
              [
                "AWS/SQS",
                "ApproximateNumberOfMessagesVisible",
                "QueueName",
                var.sqs_queue_name
              ]
            ]
          }
        }
      ] : []
    )
  })
}
