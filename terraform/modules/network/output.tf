output "valheim_server_vnet_id" {
  value = azurerm_virtual_network.valheim_server_vnet.id
}

output "valheim_server_subnet_id" {
    value = azurerm_subnet.valheim_server_subnet.id
}

