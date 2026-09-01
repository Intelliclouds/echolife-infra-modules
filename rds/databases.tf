# modules/rds/databases.tf

provider "postgresql" {
  host            = aws_db_instance.this.address
  port            = aws_db_instance.this.port
  database        = "postgres"
  username        = local.db_credentials.username
  password        = local.db_credentials.password
  sslmode         = "require"
  connect_timeout = 15
}

resource "postgresql_database" "microservices" {
  for_each = toset(var.databases)

  name  = each.key
  owner = local.db_credentials.username
}
