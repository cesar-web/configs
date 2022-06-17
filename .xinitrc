# Rebind keyboard
dash ~/code/bash/loop/change-keyboard-layout.sh &

# Keybindings to launch software and scripts
sxhkd &

# Load statusbar
dash ~/code/bash/loop/dwmstatus.sh &

# Speed up keyboard
xset r rate 300 37 &

exec dwm
