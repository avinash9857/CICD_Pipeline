resource "azurerm_mssql_database" "example" {
  name         = var.database_name
  server_id    = data.azurerm_mssql_server.server_id.id
  collation    = var.collation
  license_type = var.license_type
  max_size_gb  = var.size_gb
  sku_name     = var.sku
  enclave_type = var.enclave_type
}

data "azurerm_mssql_server" "server_id" {
  name                = var.server_name
  resource_group_name = var.rg_name
}