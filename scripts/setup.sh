#!/bin/bash

# Add 32-bit archictecture
dpkg --add-architecture i386 && apt-get update

# Add essential packages
apt-get install -y crudini cabextract p7zip-full xvfb

# Add packages for Windows Emulation, and while at it, disable automatic updates
if [[ "$(lsb_release -si)" == "Sparky" ]]; then
  echo ">>> Installing Wine: Sparky"
  apt-get remove -y sparky-aptus-upgrade-checker
  apt-get install -y --allow-downgrades wine wine32 wine64 winetricks libsvtav1enc2:amd64=2.3.0+dfsg-1
else
  echo ">>> Installing Wine: WineHQ"
  # https://www.dropvps.com/blog/install-wine-on-debian-13/
  apt-get install -y wget ca-certificates
  mkdir -pm755 /etc/apt/keyrings
  wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
  wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources
  apt-get update
  apt-get install -y wine wine32 wine64 winetricks
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
fi

# Get fix for https://github.com/Winetricks/winetricks/issues/2344
wget -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/00427b67de70bfefd282d0abc7edd1daa442e73e/src/winetricks
