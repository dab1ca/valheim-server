resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "azurerm_public_ip" "valheim_server_pip" {
  name                = locals.valheim_server.public_ip.name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface" "valheim_server_nic" {
    name                = locals.valheim_server.nic_configuration.name
    location            = var.location
    resource_group_name = var.resource_group_name
    
    ip_configuration {
        name                          = locals.valheim_server.nic_configuration.ip_configuration.name
        subnet_id                     = var.valheim_server.nic_configuration.ip_configuration.subnet_id
        private_ip_address_allocation = "Static"
        private_ip_address            = locals.valheim_server.nic_configuration.ip_configuration.private_ip_address 
        public_ip_address_id          = azurerm_public_ip.valheim_server_pip.id
    }
}

resource "azurerm_linux_virtual_machine" "valheim_server" {
  name                = locals.valheim_server.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = random_password.vm_password.result
  network_interface_ids = [
    azurerm_network_interface.valheim_server_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = var.valheim_server.source_image_id
}