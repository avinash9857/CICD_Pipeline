resource "azurerm_network_interface" "example" {
  name                = var.nic_name
  location            = var.nic_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_id.id
    public_ip_address_id          = data.azurerm_public_ip.pip_id.id
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_public_ip" "pip_id" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "subnet_id" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}