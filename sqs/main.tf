##########################################
# Main Queue
##########################################

resource "aws_sqs_queue" "this" {

  name = var.fifo_queue ?
    "${var.queue_name}.fifo" :
    var.queue_name

  fifo_queue = var.fifo_queue

  kms_master_key_id = data.aws_kms_alias.sqs.target_key_arn

  visibility_timeout_seconds = var.visibility_timeout_seconds

  message_retention_seconds = var.message_retention_seconds

  receive_wait_time_seconds = var.receive_wait_time_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })

  tags = {
    Name        = var.queue_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
