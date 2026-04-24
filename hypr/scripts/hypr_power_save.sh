#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: hypr_power_save.sh
#
# Descrição:
# Ajusta automaticamente a taxa de atualização do monitor interno, o VRR
# (Variable Refresh Rate), além do blur e animações conforme o estado
# da alimentação do notebook.
#
# Comportamento:
# - Conectado na energia (AC): ativa modo performance (144Hz + VRR + blur e animações).
# - Na bateria: ativa modo economia (60Hz + VRR off + blur e animações off).
#
# Requisitos:
# - Hyprland
# - jq
# - notify-send
#
# Observação:
# Mensagens de log são registradas com journalctl.
# TAG: hypr-power
# Para debugar, utilize: journalctl -t hypr-power -f
# -----------------------------------------------------------------------------

set -euo pipefail

# lock file para evitar execuções simultâneas
exec 9>/tmp/hypr_power.lock
if ! flock -n 9; then
  exit 0
fi

log_msg() {
  logger -t hypr-power "$1"
}

log_msg "Iniciando verificação de energia..."

USER_ID=$(loginctl list-users --no-legend | awk '{print $1}' | head -n1)
USER_ID=${USER_ID:-1000}
USER_NAME=$(id -un "$USER_ID")

export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/$USER_ID/hypr/ 2>/dev/null | head -n1)
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus"

if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  echo "ERRO: Instância do Hyprland não encontrada para o usuário $USER_NAME. Abrotando."
  log_msg "ERRO: Instância do Hyprland não encontrada para o usuário $USER_NAME. Abortando."
  exit 1
fi

MONITOR=$(sudo -u "$USER_NAME" -E hyprctl monitors -j | jq -r '.[] | select(.name | test("eDP")) | .name')
RES=$(sudo -u "$USER_NAME" -E hyprctl monitors -j | jq -r '.[] | select(.focused==true) | "\(.width)x\(.height)"')

AC_PATH=$(grep -l "Mains" /sys/class/power_supply/*/type | sed 's/type/online/' | head -n1)

if [ ! -f "$AC_PATH" ]; then
  echo "ERRO CRÍTICO: Arquivo de hardware $AC_PATH não encontrado!"
  log_msg "ERRO CRÍTICO: Arquivo de hardware $AC_PATH não encontrado!"
  exit 1
fi

ESTADO_AC=$(cat "$AC_PATH")

echo "Leitura: carregador está em $ESTADO_AC. Monitor detectado: $MONITOR ($RES)"
log_msg "Leitura: carregador está em $ESTADO_AC. Monitor detectado: $MONITOR ($RES)"

if [[ "$ESTADO_AC" == "1" ]]; then
  echo "Modo Performance (AC)"
  log_msg "Modo Performance (AC)"
  sudo -u "$USER_NAME" -E hyprctl keyword monitor "$MONITOR, $RES@144, 0x0, 1.25"
  sudo -u "$USER_NAME" -E hyprctl keyword misc:vrr 1
  sudo -u "$USER_NAME" -E hyprctl keyword decoration:blur:enabled true
  sudo -u "$USER_NAME" -E hyprctl keyword animations:enabled true
  msg="Modo Performance: 144Hz"
else
  echo "Modo Economia (Bateria)"
  log_msg "Modo Economia (Bateria)"
  sudo -u "$USER_NAME" -E hyprctl keyword monitor "$MONITOR, $RES@60, 0x0, 1.25"
  sudo -u "$USER_NAME" -E hyprctl keyword misc:vrr 0
  sudo -u "$USER_NAME" -E hyprctl keyword decoration:blur:enabled false
  sudo -u "$USER_NAME" -E hyprctl keyword animations:enabled false
  msg="Modo Economia: 60Hz"
fi

sudo -u "$USER_NAME" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus" \
  notify-send "Energia" "$msg" -i battery -t 2000

echo "Configuração aplicada com sucesso."
log_msg "Script finalizado com sucesso."
