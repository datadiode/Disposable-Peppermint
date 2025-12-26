#!/bin/bash

# Wine wants a display to create windows
Xvfb :10 -ac -screen 0 1024x768x24 &
export DISPLAY=:10

# Prepare wineprefix
wine wineboot
winetricks --unattended vcrun2015
winetricks win10
