#!/bin/sh

# A script to activate only the native laptop display in case the outputs get
# messed up and you cannot activate the correct display output.
# Author: Ioannis Petrousov
# Date: 26-11-2022

external_displays=$(xrandr | grep -w connected | cut -f 1 -d ' ' | grep -v eDP1)
set_display="xrandr --output eDP1 \
    --primary --mode 2256x1504 \
    --pos 0x0 --rotate normal \
    --scale 1 "

for ed in $external_displays
do
  set_display="${set_display} --output ${ed} --off "
done

eval "$set_display"
