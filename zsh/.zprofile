export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi

export QSYS_ROOTDIR="/var/tmp/pamac-build-master/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/23.1/quartus/sopc_builder/bin"


# Added by Antigravity CLI installer
export PATH="/home/master/.local/bin:$PATH"
