#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone "https://github.com/gabwsant/dotfiles.git" "$DOTFILES_DIR"
fi

declare -A CONFIGS=(
  ["hypr"]="$HOME/.config/hypr"
  ["waybar"]="$HOME/.config/waybar"
  ["kitty"]="$HOME/.config/kitty"
  ["rofi"]="$HOME/.config/rofi"
  ["dunst"]="$HOME/.config/dunst"
  ["btop"]="$HOME/.config/btop"
  ["zathura"]="$HOME/.config/zathura"
  ["nvim"]="$HOME/.config/nvim"
  ["mpv"]="$HOME/.config/mpv"
  ["MangoHud"]="$HOME/.config/MangoHud"
  ["gamemode.ini"]="/etc/gamemode.ini"
)

link_config() {
  local source_item=$1
  local target_path=$2
  local target_dir
  local sudo_cmd=""

  target_dir=$(dirname "$target_path")

  if [[ ! "$target_path" == "$HOME"* ]]; then
    sudo_cmd="sudo"
  fi

  if [ ! -d "$target_dir" ]; then
    $sudo_cmd mkdir -p "$target_dir"
  fi

  if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
    echo "Backing up existing $target_path ..."
    $sudo_cmd mv "$target_path" "${target_path}_backup"
  fi

  $sudo_cmd ln -sfn "$DOTFILES_DIR/$source_item" "$target_path"
}

for item in "${!CONFIGS[@]}"; do
  target_path="${CONFIGS[$item]}"

  if [ -e "$DOTFILES_DIR/$item" ]; then
    echo "Linking $item -> $target_path"
    link_config "$item" "$target_path"
  else
    echo "Warn: $item not found in $DOTFILES_DIR"
  fi
done
