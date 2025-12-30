#!/bin/bash

# Add 32-bit archictecture

dpkg --add-architecture i386

apt-get update

# Get the latest system updates except for openssh-server as it will get stuck
# apt-mark hold openssh-server
# apt-get upgrade -y

# Add essential packages
apt-get install -y crudini
apt-get install -y cabextract
apt-get install -y p7zip-full
apt-get install -y xvfb

# https://www.dropvps.com/blog/install-wine-on-debian-13/
apt-get install -y wget ca-certificates
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources
apt-get update

# Add packages for Windows Emulation
apt-get install -y wine
apt-get install -y winetricks
apt-get install -y wine32:i386

# Get fix for https://github.com/Winetricks/winetricks/issues/2344
wget -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/00427b67de70bfefd282d0abc7edd1daa442e73e/src/winetricks

# Put things in place to allow unattended creation of wine prefixes
# https://github.com/Winetricks/winetricks/issues/1236#issuecomment-1009509098

#mono
mkdir -p /opt/wine/mono
wget -O /opt/wine/mono.tar.xz "https://dl.winehq.org/wine/wine-mono/5.1.0/wine-mono-5.1.0-x86.tar.xz"
tar -xf /opt/wine/mono.tar.xz -C /opt/wine/mono
rm /opt/wine/mono.tar.xz

#gecko
mkdir -p /opt/wine/gecko
wget -O /opt/wine/gecko/gecko.tar.bz2 "https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.tar.bz2" 
tar -xf /opt/wine/gecko/gecko.tar.bz2 -C /opt/wine/gecko
rm /opt/wine/gecko/gecko.tar.bz2
