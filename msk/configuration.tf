##########################################
# Kafka Configuration
##########################################

resource "aws_msk_configuration" "this" {

  name = "echolife-${var.environment}-config"

  kafka_versions = [
    var.kafka_version
  ]

  server_properties = <<PROPERTIES
auto.create.topics.enable=true
delete.topic.enable=true
default.replication.factor=3
min.insync.replicas=2
num.partitions=3
PROPERTIES
}
