#!/usr/bin/env bash
#    ___
#   / _ \___ _     _____ ____
#  / ___/ _ \ |/|/ / -_) __/
# /_/   \___/__,__/\__/_/
#

terminate_clients() {
  local timeout=5
  local start_time
  local current_time
  local elapsed=0

  local client_pids
  client_pids=$(hyprctl clients -j | jq -r '.[] | select(.pid > 0) | .pid' | sort -u)

  if [[ -z "$client_pids" ]]; then
    echo ":: Nenhum cliente ativo encontrado."
    return 0
  fi

  echo ":: Enviando SIGTERM para os clientes..."
  echo "$client_pids" | xargs -r kill -15 2>/dev/null

  start_time=$(date +%s)

  while true; do
    local still_running=0
    for pid in $client_pids; do
      if kill -0 "$pid" 2>/dev/null; then
        still_running=$((still_running + 1))
      fi
    done

    if [[ $still_running -eq 0 ]]; then
      echo ":: Todos os clientes foram encerrados com sucesso."
      break
    fi

    current_time=$(date +%s)
    elapsed=$((current_time - start_time))

    if [[ $elapsed -ge $timeout ]]; then
      echo ":: Timeout de $timeout segundos atingido. Forçando encerramento..."
      for pid in $client_pids; do
        if kill -0 "$pid" 2>/dev/null; then
          echo ":: Forçando PID $pid (SIGKILL)"
          kill -9 "$pid" 2>/dev/null
        fi
      done
      break
    fi

    echo ":: Aguardando $still_running processo(s) terminar(em)... ($elapsed s)"
    sleep 0.5
  done
}

case "$1" in
exit)
  echo ":: Encerrando sessão"
  terminate_clients
  sleep 0.2
  hyprshutdown --vt 1
  ;;
lock)
  echo ":: Bloqueando tela"
  sleep 0.2
  hyprlock
  ;;
reboot)
  echo ":: Reiniciando"
  terminate_clients
  sleep 0.2
  systemctl reboot
  ;;
shutdown)
  echo ":: Desligando"
  terminate_clients
  sleep 0.2
  systemctl poweroff
  ;;
suspend)
  echo ":: Suspendendo"
  sleep 0.2
  systemctl suspend
  ;;
hibernate)
  echo ":: Hibernando"
  sleep 0.2
  systemctl hibernate
  ;;
*)
  echo "Uso: ${0##*/} {exit|lock|reboot|shutdown|suspend|hibernate}"
  exit 1
  ;;
esac
