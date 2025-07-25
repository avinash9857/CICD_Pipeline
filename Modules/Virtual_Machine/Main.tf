resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.vm_location
  size                = var.size
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [data.azurerm_network_interface.nic_id.id]
  disable_password_authentication = false


  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}

data "azurerm_network_interface" "nic_id" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}