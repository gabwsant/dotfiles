# Dotfiles

These dotfiles are built for a simple, efficient and stylish Arch Linux environment using Hyprland (Wayland) as the window manager.

It's not 100% pure my creation, there are configs from many repos. It also includes many optional packages and tools that I personally use - you don't need to install all of them.

---

## Preview

Make assets folder.

---

## Softwares

| Category           | Software   |
| ------------------ | ---------- |
| WM                 | Hyprland   |
| Lock screen        | Hyprlock   |
| Idle               | Hypridle   |
| Wallpaper          | Hyprpaper  |
| Blue light filter  | Hyprsunset |
| Bar                | Waybar     |
| Launcher           | Rofi       |
| Terminal           | Kitty      |
| Editor             | Neovim     |
| PDF                | Zathura    |
| Notifications      | Dunst      |
| Media player       | mpv        |
| Process management | btop       |


---

## Theme

* GTK: Catppuccin Mocha
* Icons: Papirus
* Cursor: Catppuccin
* Font: JetBrains Mono Nerd Font

---

## Install

Clone:

```bash
git clone https://github.com/gabwsant/dotfiles.git
cd dotfiles
```

Backup your current files.

Make symbolic links:

```bash
ln -sf ~/dotfiles/hypr ~/.config/hypr
ln -sf ~/dotfiles/waybar ~/.config/waybar
ln -sf ~/dotfiles/kitty ~/.config/kitty
ln -sf ~/dotfiles/rofi ~/.config/rofi
ln -sf ~/dotfiles/nvim ~/.config/nvim
etc...
```

Or execute the script:

```bash
./install.sh
```

---

## Dependencies

Intall needed packages:

```text
hyprland
hyprlock
hypridle
hyprpaper
hyprsunset
hyprshutdown
waybar
kitty
rofi
dunst
neovim
zathura
papirus-icon-theme
ttf-jetbrains-mono-nerd

jq
```

---

## Wallpapers

```text
wallpapers/
```

---

## Scripts

`scripts/` folder has some utilities for:

* Power saving for laptops
* Rofi's menus for dunst and power
* Power (shutdown safely)
* Airplane mode

---

## Caution

These dotfiles were made for my desktop and may not work properly without adaptations.

Feel free to use parts of the project or adapt to your needs.
