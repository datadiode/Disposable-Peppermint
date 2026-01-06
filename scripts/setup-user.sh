#!/bin/bash

# Set presentation mode as configured in Vagrantfile
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s $PRESENTATION_MODE -n -t bool

# Create .i18n from what is found in current environment
cat << EOF > .i18n
export LANGUAGE=$LANGUAGE
export LANG=$LANG
export LC_ALL=$LC_ALL
setxkbmap $KEYBOARD_LANGUAGE
EOF

# Source .i18n from .config/xfce4/xinitrc
mkdir -p .config/xfce4
cp /home/vagrant/files/xinitrc .config/xfce4/

xdg-user-dirs-update --force

# Wine wants a display to create windows
Xvfb $DISPLAY -ac -screen 0 1024x768x24 &

# Prepare wineprefix
wine wineboot
winetricks --unattended $WINETRICKS_VERBS

# Create desktop icons
cp /usr/share/applications/*cpu-x.desktop Desktop/

exit 0
