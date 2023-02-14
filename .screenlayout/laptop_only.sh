#!/bin/sh

# A script to activate only the native laptop display in case the outputs get
# messed up and you cannot activate the correct display output.
# Author: Ioannis Petrousov
# Date: 26-11-2022


# Settings for laptop display
set_display="xrandr --output eDP1 \
  --primary --mode 2256x1504 \
  --pos 0x0 --rotate normal \
  --scale 1x1"

echo ${set_display}

eval "$set_display"
