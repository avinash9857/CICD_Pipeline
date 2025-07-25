resource "azurerm_mssql_server" "example" {
  name                         = var.mssql_server_name
  resource_group_name          = var.rg_name
  location                     = var.server_location
  version                      = "12.0"
  administrator_login          = var.adminuser
  administrator_login_password = var.password
  minimum_tls_version          = var.tls_version
}