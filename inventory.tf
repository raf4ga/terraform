resource "local_file" "prod" {
  count    = 5
  content  = "Inventario"
  filename = "inventory-${random_string.randomfile[count.index].id}.txt"

}

resource "random_string" "randomfile" {
  count            = 5
  length           = 4
  upper            = true
  lower            = true
  numeric          = true
  special          = true
  override_special = "/-"

}