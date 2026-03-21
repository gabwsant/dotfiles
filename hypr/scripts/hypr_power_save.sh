#!/bin/bash

USER_NAME="gabs"
USER_ID="1000"
MONITOR="eDP-1"
RES="1920x1200"
AC_PATH="/sys/class/power_supply/ADP0/online"

export HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/$USER_ID/hypr | head -n 1)
export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus"

if [ "$(cat $AC_PATH)" = "1" ]; then
  hyprctl keyword monitor "$MONITOR, $RES@144, 0x0, 1.25"
  hyprctl keyword misc:vrr 1
  echo "Modo Performance: 144Hz"
  msg="Modo Performance: 144Hz"
else
  hyprctl keyword monitor "$MONITOR, $RES@60, 0x0, 1.25"
  hyprctl keyword misc:vrr 0
  echo "Modo Economia: 60Hz"
  msg="Modo Economia: 60Hz"
fi

sleep 1
notify-send "Energia" "$msg" -i "$icon" -t 2000
