#!/bin/bash

# Create .i18n from what is found in current environment
cat << EOF > .i18n
export LANGUAGE=$LANGUAGE
export LANG=$LANG
export LC_ALL=$LC_ALL
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
