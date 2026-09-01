resource "aws_sns_topic" "cloudwatch_alerts" {
  name = "${var.project_name}-${var.environment}-cloudwatch-alerts"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_sns_topic_subscription" "email" {
  count = var.alarm_email != "" ? 1 : 0

  topic_arn = aws_sns_topic.cloudwatch_alerts.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  count = var.alb_arn_suffix != "" ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-alb-5xx"
  alarm_description   = "ALB 5XX errors are above threshold"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 10

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.cloudwatch_alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_targets" {
  count = var.target_group_arn_suffix != "" && var.alb_arn_suffix != "" ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-alb-unhealthy-targets"
  alarm_description   = "ALB has unhealthy targets"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Average"
  threshold           = 1

  dimensions = {
    TargetGroup  = var.target_group_arn_suffix
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.cloudwatch_alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  count = var.rds_instance_identifier != "" ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-rds-cpu"
  alarm_description   = "RDS CPU utilization is above 80%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }

  alarm_actions = [
    aws_sns_topic.cloudwatch_alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "rds_storage" {
  count = var.rds_instance_identifier != "" ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-rds-storage"
  alarm_description   = "RDS free storage is below 10 GB"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 10737418240

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }

  alarm_actions = [
    aws_sns_topic.cloudwatch_alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "redis_cpu" {
  count = var.redis_replication_group_id != "" ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-redis-cpu"
  alarm_description   = "Redis CPU utilization is above 80%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "EngineCPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    ReplicationGroupId = var.redis_replication_group_id
  }

  alarm_actions = [
    aws_sns_topic.cloudwatch_alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "sqs_messages" {
  count = var.sqs_queue_name != "" ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-sqs-messages"
  alarm_description   = "SQS queue has too many pending messages"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 300
  statistic           = "Average"
  threshold           = 100

  dimensions = {
    QueueName = var.sqs_queue_name
  }

  alarm_actions = [
    aws_sns_topic.cloudwatch_alerts.arn
  ]
}
