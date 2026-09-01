##########################################
# Dead Letter Queue
##########################################

resource "aws_sqs_queue" "dlq" {

  name = var.fifo_queue ?
    "${var.queue_name}-dlq.fifo" :
    "${var.queue_name}-dlq"

  fifo_queue = var.fifo_queue

  kms_master_key_id = data.aws_kms_alias.sqs.target_key_arn

  message_retention_seconds = 1209600

  tags = {
    Name        = "${var.queue_name}-dlq"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
