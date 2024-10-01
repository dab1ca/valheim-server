data "terraform_remote_state" "core" {
  backend = "azurerm"
  config = {
    resource_group_name  = "ttsv-rg" # Valheim backend resource group
    storage_account_name = "ttsvsauksouth" # Valheim backend storage account
    container_name       = "valheim"
    key                  = "core.tfstate"
  }
}
