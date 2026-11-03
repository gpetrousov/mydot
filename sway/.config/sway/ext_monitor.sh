#!/bin/bash

entries="1) Laptop monitor On\n2) Laptop monitor Off\n3) Home Setup"

selected=$(echo -e $entries|wofi --width 250 --height 240 --dmenu --cache-file /dev/null | cut -f 1 -d ")")

case $selected in
        1)
                swaymsg output eDP-1 enable mode 2256x1504@60Hz scale 2 pos 1128 1440
        ;;
        2)
                swaymsg output eDP-1 disable
        ;;
        3)
                swaymsg output DP-1 mode 3440x1440@60Hz scale 1 pos 2256 1440
                swaymsg output eDP-1 disable
esac
