resource "azurerm_virtual_network" "valheim_server_vnet" {
    name                = locals.vnet.vnet_name
    resource_group_name = var.resource_group_name
    location            = var.location
    address_space       = locals.vnet.address_space
}

resource "azurerm_subnet" "valheim_server_subnet" {
    name = locals.vnet.valheim_server_subnet.name
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.valheim_server_vnet.name
    address_prefixes = locals.vnet.valheim_server_subnet.address_prefixes
}

resource "azurerm_network_security_group" "valheim_server_nsg" {
    name                = locals.vnet.valheim_server_subnet.nsg.name
    resource_group_name = var.resource_group_name
    location            = var.location

    dynamic "security_rule" {
    for_each = locals.vnet.valheim_server_subnet.nsg.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_ranges          = security_rule.value.source_port_ranges
      destination_port_ranges     = security_rule.value.destination_port_ranges
      source_address_prefixes      = security_rule.value.source_address_prefixes
      destination_address_prefixes = security_rule.value.destination_address_prefixes
    }
  }
}