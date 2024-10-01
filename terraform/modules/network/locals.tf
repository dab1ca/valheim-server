locals {
    vnet = {
        vnet_name = "valheim-server-vnet"
        address_space = ["192.168.200.0/24"]

        valheim_server_subnet = {
            name = "valheim-server-subnet"
            address_prefixes = ["192.168.200.0/28"]

            nsg = {
                name = "valheim-server-nsg"
                nsg_rules = [
                    {
                        name                       = "allow-ssh"
                        priority                   = 110
                        direction                  = "Inbound"
                        access                     = "Allow"
                        protocol                   = "Tcp"
                        source_port_ranges         = ["*"]
                        destination_port_ranges    = ["22"]
                        source_address_prefixes    = [] # Add IP Address to access Server
                        destination_address_prefixes = ["*"]
                    },
                    {
                        name                       = "allow-valheim-ports-tcp"
                        priority                   = 110
                        direction                  = "Inbound"
                        access                     = "Allow"
                        protocol                   = "Tcp"
                        source_port_ranges         = ["*"]
                        destination_port_ranges    = ["2456-2458"]
                        source_address_prefixes    = ["*"] # Add IP Address to access Server
                        destination_address_prefixes = ["*"]
                    },
                    {
                        name                       = "allow-valheim-ports-udp"
                        priority                   = 110
                        direction                  = "Inbound"
                        access                     = "Allow"
                        protocol                   = "Udp"
                        source_port_ranges         = ["*"]
                        destination_port_ranges    = ["2456-2458"]
                        source_address_prefixes    = ["*"] # Add IP Address to access Server
                        destination_address_prefixes = ["*"]
                    }
                ]
            }
        }
    }
}