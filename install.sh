#!/bin/bash
# Vanilla Mobile by Alan Escarcha Installation Script
# https://github.com/alanescarcha/terraria-mobile-server
#
# Server Files: /mnt/server
## install packages to get version and download links
apt update
apt install -y curl wget file unzip fastjar
mkdir -p /mnt/server/
cd /mnt/server/
echo -e "Downloading terraria server files"
DOWNLOAD_LINK=https://github.com/jbndis/Skynode-Terraria-Mobile-Fix/releases/download/Latest/ServerLinux.zip
## this is a simple script to validate a download url actaully exists
CLEAN_VERSION=$(echo ${DOWNLOAD_LINK##*/} | cut -d'-' -f3 | cut -d'.' -f1)
echo -e "running 'curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}'"
curl -sSL https://github.com/jbndis/Skynode-Terraria-Mobile-Fix/releases/download/Latest/ServerLinux.zip -o ${DOWNLOAD_LINK##*/}
echo -e "Unpacking server files"
jar xvf ${DOWNLOAD_LINK##*/}
echo -e ""
cp -R ${CLEAN_VERSION}/* ./
./patcher.ps1
chmod +x TerrariaServer.bin.x86_64
echo -e "Cleaning up extra files."
rm -rf ${CLEAN_VERSION}
echo -e "Generating config file"
cat <<EOF > serverconfig.txt
worldpath=/home/container/saves/Worlds
worldname=default
world=/home/container/saves/Worlds/default.wld
difficulty=3
autocreate=1
port=7777
maxplayers=8
EOF
mkdir -p /mnt/server/saves/Worlds
echo -e "Install complete"
