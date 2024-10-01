output "server_resource_group_name" {
  value = azurerm_resource_group.valheim_server_rg.name
}

output "keyvault_id" {
  value = azurerm_key_vault.valheim_server_kv.id
}

output "valheim_server_img_id" {
  value = azurerm_shared_image.valheim_server_img.id
}