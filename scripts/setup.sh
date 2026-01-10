#!/bin/bash

# Add 32-bit archictecture
dpkg --add-architecture i386 && apt-get update

# Add essential packages
apt-get install -y crudini cabextract p7zip-full xvfb cpu-x systemd-sysv devilspie2

# Disable automatic updates
if [[ "$(lsb_release -si)" == "Sparky" ]]; then
  apt-get remove -y sparky-aptus-upgrade-checker
fi

# Add packages for Windows Emulation
apt-get install -y wine wine32 wine64 winetricks

# Enable auto login
if $AUTO_LOGIN; then
  crudini --set /etc/lightdm/lightdm.conf "Seat:*" autologin-user vagrant
  crudini --set /etc/lightdm/lightdm.conf "Seat:*" autologin-user-timeout 0
fi

# Disable session saving
mkdir /etc/xdg/xfce4/kiosk
crudini --set /etc/xdg/xfce4/kiosk/kioskrc "xfce4-session" SaveSession NONE

# Disable user-dirs update prompt
crudini --set /etc/xdg/autostart/user-dirs-update-gtk.desktop "Desktop Entry" Hidden true

# On orion-belt, use files for bookworm if such exist
if [[ "$(lsb_release -si)" == "Sparky" ]]; then
  ln -s /home/vagrant/files/bookworm /home/vagrant/files/orion-belt
fi

exit 0
