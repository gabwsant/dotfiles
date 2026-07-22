#!/bin/bash

NOTIFICATIONS=$(dunstctl history | jq -r '.data[0][] | "\(.id.data) | \(.appname.data): \(.summary.data | gsub("\n"; " "))"')

if [ -z "$NOTIFICATIONS" ]; then
  rofi -e "No notifications in the history."
  exit 0
fi

CHOSEN=$(echo "$NOTIFICATIONS" | rofi -dmenu -i -p "Old notifications:")

if [ -z "$CHOSEN" ]; then
  exit 0
fi

NOTIFICATION_ID=$(echo "$CHOSEN" | awk -F ' \\| ' '{print $1}')

dunstctl history-pop "$NOTIFICATION_ID"
