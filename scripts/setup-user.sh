#!/bin/bash

# Wine wants a display to create windows
Xvfb $DISPLAY -ac -screen 0 1024x768x24 &

# Prepare wineprefix
wine wineboot
winetricks --unattended $WINETRICKS_VERBS
