locals {
    valheim_server = {
        name = "valheim-server"
        public_ip = {
            name = "valheim-server-pip"
        }
        nic_configuration = {
            name = "valheim-server-nic"
            ip_configuration = {
                name = "valheim-server-ip-config"
                private_ip_address = "192.168.200.10"
            }
        }
    }
}