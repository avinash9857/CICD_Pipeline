module "rg" {
  source      = "../../Modules/Resource_Group"
  rg_name     = "avirg27"
  rg_location = "japaneast"
}

module "vnet" {
  depends_on    = [module.rg]
  source        = "../../Modules/Virtual_Network"
  vnet_name     = "avivnet"
  vnet_location = "japaneast"
  rg_name       = "avirg27"
  address_space = ["10.0.0.0/16"]
}

module "subnet1" {
  depends_on       = [module.vnet]
  source           = "../../Modules/Subnet"
  subnet_name      = "avisubnet1"
  rg_name          = "avirg27"
  vnet_name        = "avivnet"
  address_prefixes = ["10.0.1.0/24"]
}

module "subnet2" {
  depends_on       = [module.vnet]
  source           = "../../Modules/Subnet"
  subnet_name      = "avisubnet2"
  rg_name          = "avirg27"
  vnet_name        = "avivnet"
  address_prefixes = ["10.0.2.0/24"]
}

module "pip1" {
  depends_on   = [module.subnet1]
  source       = "../../Modules/Public_IP"
  pip_name     = "avipip1"
  rg_name      = "avirg27"
  pip_location = "japaneast"
}

module "pip2" {
  depends_on   = [module.subnet2]
  source       = "../../Modules/Public_IP"
  pip_name     = "avipip2"
  rg_name      = "avirg27"
  pip_location = "japaneast"
}

module "nic1" {
  depends_on   = [module.pip1]
  source       = "../../Modules/NIC"
  nic_name     = "avinic1"
  nic_location = "japaneast"
  rg_name      = "avirg27"
  subnet_name  = "avisubnet1"
  vnet_name    = "avivnet"
  pip_name     = "avipip1"
}

module "nic2" {
  depends_on   = [module.pip2]
  source       = "../../Modules/NIC"
  nic_name     = "avinic2"
  nic_location = "japaneast"
  rg_name      = "avirg27"
  subnet_name  = "avisubnet2"
  vnet_name    = "avivnet"
  pip_name     = "avipip2"
}

module "vm1" {
  depends_on           = [module.nic1]
  source               = "../../Modules/Virtual_Machine"
  vm_name              = "avivm1"
  rg_name              = "avirg27"
  vm_location          = "japaneast"
  size                 = "Standard_B1s"
  username             = "adminuser"
  password             = "Avik@1234"
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  publisher            = "Canonical"
  offer                = "0001-com-ubuntu-server-jammy"
  sku                  = "22_04-lts"
  nic_name             = "avinic1"
}

module "vm2" {
  depends_on           = [module.nic2]
  source               = "../../Modules/Virtual_Machine"
  vm_name              = "avivm2"
  rg_name              = "avirg27"
  vm_location          = "japaneast"
  size                 = "Standard_B1s"
  username             = "adminuser"
  password             = "Avik@1234"
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  publisher            = "Canonical"
  offer                = "0001-com-ubuntu-server-jammy"
  sku                  = "22_04-lts"
  nic_name             = "avinic2"
}

# module "sqlserver" {
#   depends_on           = [ module.vm2]
#   source               = "../../Modules/SQL_Server"
#   mssql_server_name = "avimssqlserver"
#   rg_name = "avirg27"
#   server_location = "japaneast"
#   adminuser = "adminuser"
#   password = "Avik@1234"
#   tls_version = "1.2"
# }

# module "sqldb" {
#   depends_on = [ module.sqlserver ]
#  source = "../../Modules/SQL_Database"
#  database_name = "avimysqldb"
#   collation = "SQL_Latin1_General_CP1_CI_AS"
#   license_type = "LicenseIncluded"
#   size_gb = 32
#   sku = "GP_Gen5_2"
#   enclave_type = "VBS"
#   server_name = "avimssqlserver"
#   rg_name = "avirg27"
# }
  