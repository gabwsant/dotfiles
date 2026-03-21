#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: hypr_power_save.sh
#
# Descrição:
# Ajusta automaticamente a taxa de atualização do monitor interno e o VRR
# (Variable Refresh Rate) conforme o estado da alimentação do notebook.
#
# Comportamento:
# - Conectado na energia (AC): ativa modo performance (144Hz + VRR).
# - Na bateria: ativa modo economia (60Hz + VRR desligado).
#
# Requisitos:
# - Hyprland
# - jq
# - notify-send
#
# -----------------------------------------------------------------------------

set -euo pipefail

USER_ID=$(id -u)

# Detecta o monitor interno (normalmente eDP em laptops)
MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.name | test("eDP")) | .name')

# Obtém resolução atual do monitor focado
RES=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | "\(.width)x\(.height)"')

# Caminho que indica se o carregador está conectado
AC_PATH="/sys/class/power_supply/ADP0/online"

# Variáveis necessárias para acessar a sessão do Hyprland
export HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/$USER_ID/hypr | head -n1)
export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus"

echo "Monitor detectado: $MONITOR"
echo "Resolução atual: $RES"

# Verifica se o carregador está conectado
if [[ "$(cat "$AC_PATH")" == "1" ]]; then

  echo "Energia AC detectada — ativando modo performance"

  echo "Aplicando: $RES@144"
  hyprctl keyword monitor "$MONITOR, $RES@144, 0x0, 1.25"

  echo "Ativando VRR"
  hyprctl keyword misc:vrr 1

  msg="Modo Performance: 144Hz"

else

  echo "Funcionando na bateria — ativando modo economia"

  echo "Aplicando: $RES@60"
  hyprctl keyword monitor "$MONITOR, $RES@60, 0x0, 1.25"

  echo "Desativando VRR"
  hyprctl keyword misc:vrr 0

  msg="Modo Economia: 60Hz"

fi

# Pequeno delay para garantir que DBus esteja pronto
sleep 1

# Notificação para o usuário
notify-send "Energia" "$msg" -t 2000

echo "Configuração aplicada com sucesso."
