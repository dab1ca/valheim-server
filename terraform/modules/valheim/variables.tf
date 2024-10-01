variable "location" {
    description = "Location of resources"
    type        = string
}

variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "valheim_server" {
    description = "Valheim server configuration"
    type        = object({
      name = string
      source_image_id = string
      nic_configuration = object({
        ip_configuration = object({
          subnet_id = string
        })
      })
    })
}