resource "azurerm_resource_group" "valheim_server_rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_shared_image_gallery" "valheim_server_cg" {
  name                = var.gallery_name
  resource_group_name = var.rg_name
  location            = var.location
}

resource "azurerm_shared_image" "valheim_server_img" {
    name                = "valheim-server-image"
    gallery_name        = azurerm_shared_image_gallery.valheim_server_cg.name
    resource_group_name = azurerm_resource_group.valheim_server_rg.name
    location            = var.location
    hyper_v_generation  = "V2"          
    os_type             = "Linux"
    architecture        = "x64"
    trusted_launch_supported = true
    min_recommended_vcpu_count = 1
    max_recommended_vcpu_count = 16
    min_recommended_memory_in_gb = 1
    max_recommended_memory_in_gb = 32

    identifier {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "24_04-lts"
    }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "valheim_server_kv" {
  name                = "valheim-server-kv"
  resource_group_name = azurerm_resource_group.valheim_server_rg.name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

resource "azurerm_role_assignment" "tf_user" {
  scope                = azurerm_key_vault.valheim_server_kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}