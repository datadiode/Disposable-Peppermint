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

# Add packages for Windows Emulation
apt-get install -y wine
apt-get install -y winetricks
apt-get install -y wine32:i386
