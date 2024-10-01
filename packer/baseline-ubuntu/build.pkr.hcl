build {
  sources = [
    "source.azure-arm.vm"
  ]

  provisioner shell {
    execute_command = local.execute_command
    inline = ["sudo apt update"]
  }

  provisioner shell {
    execute_command = local.execute_command
    inline = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    only = ["azure-arm"]
  }
  
  provisioner file {
    source      = "scripts/install-steamcmd.sh"
    destination = "/tmp/install-steamcmd.sh"
  }

  provisioner shell {
    inline = ["sudo bash /tmp/install-steamcmd.sh"]
  }

  provisioner shell {
    inline = [
      "/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/packer/valheimserver +login anonymous +app_update 896660 +quit"
    ]
  }

  provisioner file {
    source      = "files/valheimserver.service"
    destination = "/tmp/valheimserver.service"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/valheimserver.service /etc/systemd/system/valheimserver.service"]
  }

  provisioner "shell" {
    inline = ["sudo systemctl enable valheimserver"]
  }
}