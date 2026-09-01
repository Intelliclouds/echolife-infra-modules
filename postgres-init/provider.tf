provider "postgresql" {

  host = var.host

  port = var.port

  username = var.username

  password = var.password

  database = "postgres"

  sslmode = "require"
}
