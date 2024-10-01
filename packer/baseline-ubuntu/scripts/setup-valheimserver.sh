#!/bin/bash
sudo ufw allow 2456:2458/udp
sudo ufw allow 2456:2458/tcp

sudo useradd -m valheim
sudo -u valheim -s
cd ~
/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/valheim/valheimserver +login anonymous +app_update 896660 +quit