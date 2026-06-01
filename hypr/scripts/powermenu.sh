#!/usr/bin/env bash

POWER_SCRIPT="$HOME/.config/hypr/scripts/power.sh"

# Opções do menu
lock="󰌾 Lock"
logout="󰍃 Logout"
suspend="󰤄 Suspend"
hibernate="󰒲 Hibernate"
reboot="󰜉 Reboot"
shutdown="󰐥 Shutdown"

selected=$(printf '%s\n' "$lock" "$logout" "$suspend" "$hibernate" "$reboot" "$shutdown" |
  rofi -dmenu -i -p "Power" -theme-str 'window {width: 20%; height: 15%;}')

case "$selected" in
"$lock")
  "$POWER_SCRIPT" lock
  ;;
"$logout")
  "$POWER_SCRIPT" exit
  ;;
"$suspend")
  "$POWER_SCRIPT" suspend
  ;;
"$hibernate")
  "$POWER_SCRIPT" hibernate
  ;;
"$reboot")
  "$POWER_SCRIPT" reboot
  ;;
"$shutdown")
  "$POWER_SCRIPT" shutdown
  ;;
esac
