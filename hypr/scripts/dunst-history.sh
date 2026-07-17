#!/usr/bin/env bash

notification_list=$(dunstctl history | jq -r '
  .data[0] | reverse | .[] | 
  "[" + (.appname.data // "Sem Nome") + "] " + (.summary.data // "Sem Título") + " - " + (.body.data // "Sem Conteúdo")
' 2>/dev/null)

if [ -z "$notification_list" ]; then
  echo "Nenhuma notificação no histórico." | rofi -dmenu -p "Notificações" -theme-str 'window {width: 300px;}'
  exit 0
fi

echo "$notification_list" | rofi -dmenu -i -p "Histórico" -theme-str 'window {width: 800px;}'
