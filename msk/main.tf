##########################################
# MSK Cluster
##########################################

resource "aws_msk_cluster" "this" {

  cluster_name = var.cluster_name

  kafka_version = var.kafka_version

  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {

    instance_type = var.broker_instance_type

    client_subnets = var.private_subnet_ids

    security_groups = [
      aws_security_group.msk.id
    ]

    storage_info {
      ebs_storage_info {
        volume_size = var.ebs_volume_size
      }
    }
  }

  encryption_info {

    encryption_at_rest_kms_key_arn =
      data.aws_kms_alias.msk.target_key_arn

    encryption_in_transit {

      client_broker = "TLS"

      in_cluster = true
    }
  }

  configuration_info {

    arn      = aws_msk_configuration.this.arn
    revision = aws_msk_configuration.this.latest_revision
  }

  logging_info {

    broker_logs {

      cloudwatch_logs {

        enabled = true

        log_group = "/aws/msk/${var.cluster_name}"
      }
    }
  }

  tags = {
    Name        = var.cluster_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
