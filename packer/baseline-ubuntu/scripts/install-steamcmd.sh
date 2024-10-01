#!/bin/bash
sudo apt update && sudo apt upgrade -y

sudo apt install -y software-properties-common
sudo add-apt-repository -y multiverse
sudo dpkg --add-architecture i386
sudo apt update

echo steam steam/question select "I AGREE" | sudo debconf-set-selections
echo steam steam/license note '' | sudo debconf-set-selections

sudo apt install -y lib32gcc-s1 steamcmd
sudo apt update
