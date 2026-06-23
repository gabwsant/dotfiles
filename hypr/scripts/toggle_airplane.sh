#!/bin/bash
if rfkill list wifi | grep -q "Soft blocked: yes"; then
  rfkill unblock all
  notify-send "Modo Avião" "Desativado (Redes Conectadas)" --icon=network-transmit-receive -h string:x-canonical-private-synchronous:airplane
else
  rfkill block all
  notify-send "Modo Avião" "Ativado (Offline)" --icon=network-offline -h string:x-canonical-private-synchronous:airplane
fi
