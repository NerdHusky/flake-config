#!/bin/bash

# Apply wallpaper using wal
# wal -b 282738 -i ~/Wallpaper/Aesthetic2.png &&
wal -b 282738 -i /home/carlo/Pictures/walls/artstation_awesomewm.jpg &&

# Start picom
picom --config ~/.config/picom/picom.conf &
