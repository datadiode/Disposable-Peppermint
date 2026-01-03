#!/bin/bash

# Add 32-bit archictecture
dpkg --add-architecture i386 && apt-get update

# Add essential packages
apt-get install -y crudini cabextract p7zip-full xvfb

# Disable automatic updates
if [[ "$(lsb_release -si)" == "Sparky" ]]; then
  apt-get remove -y sparky-aptus-upgrade-checker
fi

# Add packages for Windows Emulation
apt-get install -y wine wine32 wine64 winetricks
