swayidle -w \
        timeout 600 'swaylock -f -c 000100' \
        timeout 610 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
        before-sleep 'swaylock -f -c 000000'
