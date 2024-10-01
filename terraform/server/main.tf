module "network" {
    source = "./../modules/network"
    resource_group_name = data.terraform_remote_state.core.outputs.server_resource_group_name
    location = var.location
}

module "server" {
    source = "./../modules/valheim"
    resource_group_name = data.terraform_remote_state.core.outputs.server_resource_group_name
    location = var.location
    valheim_server = {
        name = "valheim-server"
        source_image_id = data.terraform_remote_state.core.outputs.valheim_server_img_id
        nic_configuration = {
            ip_configuration = {
                subnet_id = module.network.subnet_id
            }
        }
    }
    depends_on = [ module.network ]
}

resource "azurerm_key_vault_secret" "server_password" {
  name         = "valheim-server-password"
  value        = module.server.vm_password
  key_vault_id = data.terraform_remote_state.core.outputs.keyvault_id
}