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

wget $YSETUP -O ysetup.exe
wine ysetup.exe -systempath "C:\Program Files\Yori"

# Create desktop icons
cp /usr/share/applications/*cpu-x.desktop Desktop/

# Create systemd user service to start Devilspie2 upfront
mkdir -p ~/.config/systemd/user
cat << EOF > ~/.config/systemd/user/devilspie2.service
[Unit]
Description=Devilspie2
Requires=xdg-desktop-autostart.target
StartLimitInterval=10
StartLimitBurst=5

[Service]
ExecStart=/usr/bin/devilspie2
Restart=always
RestartSec=1

[Install]
WantedBy=default.target
EOF
mkdir -p ~/.config/systemd/user/default.target.wants
ln -s ~/.config/systemd/user/devilspie2.service ~/.config/systemd/user/default.target.wants/devilspie2.service
mkdir -p ~/.config/devilspie2

# Show time with seconds
plugin=$(xfconf-query -c xfce4-panel -lv | grep -w clock$ | grep -o ^\\S*)
xfconf-query -c xfce4-panel -pn $plugin/digital-time-format -t string -s "%T"

# Sparky only: Set title of Actions button according to CORNER_TEXT setting from Vagrantfile
if [[ "$(lsb_release -si)" == "Sparky" ]]; then
  plugin=$(xfconf-query -c xfce4-panel -lv | grep -w actions$ | grep -o ^\\S*)
  xfconf-query -c xfce4-panel -pn $plugin/custom-title -t string -s " $(date +"$CORNER_TEXT") "
  xfconf-query -c xfce4-panel -pn $plugin/button-title -t int -s 3
fi

exit 0
