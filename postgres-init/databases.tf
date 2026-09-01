resource "postgresql_database" "dbs" {

  for_each = toset(var.databases)

  name = each.value

  owner = var.username

  encoding = "UTF8"

  lc_collate = "en_US.UTF-8"

  lc_ctype = "en_US.UTF-8"

  template = "template0"
}
