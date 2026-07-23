# Dotfiles

Minha configuração pessoal para **Arch Linux** utilizando **Hyprland** como compositor Wayland.

> **Status:** Em constante evolução. Algumas configurações podem mudar sem aviso.

---

## Preview



Criar pasta assets

---

## Principais recursos

* Hyprland em Lua
* Waybar personalizada
* Rofi como launcher
* Kitty como terminal
* Neovim (LazyVim)
* Bash
* Dunst para notificações
* Hyprlock
* Hypridle
* Hyprpaper
* Hyprsunset
* Catppuccin Mocha
* Scripts utilitários para automação

---

## Software utilizado

| Categoria       | Programa  |
| --------------- | --------- |
| WM              | Hyprland  |
| Barra           | Waybar    |
| Launcher        | Rofi      |
| Terminal        | Kitty     |
| Shell           | Bash      |
| Editor          | Neovim    |
| PDF             | Zathura   |
| Notificações    | Dunst     |
| Bloqueio        | Hyprlock  |
| Idle            | Hypridle  |
| Papel de parede | Hyprpaper |

---

## Tema

* GTK: Catppuccin Mocha
* Ícones: Papirus
* Cursor: Catppuccin
* Fonte: JetBrains Mono Nerd Font

---

## Instalação

Clone o repositório:

```bash
git clone https://github.com/SEU_USUARIO/dotfiles.git
cd dotfiles
```

Faça backup dos seus arquivos atuais.

Depois crie os links simbólicos:

```bash
ln -sf ~/dotfiles/hypr ~/.config/hypr
ln -sf ~/dotfiles/waybar ~/.config/waybar
ln -sf ~/dotfiles/kitty ~/.config/kitty
ln -sf ~/dotfiles/rofi ~/.config/rofi
ln -sf ~/dotfiles/nvim ~/.config/nvim
```

Ou utilize o script:

```bash
./install.sh
```

---

## Dependências

Instale os pacotes necessários.

```text
hyprland
waybar
kitty
rofi-wayland
dunst
hyprlock
hypridle
hyprpaper
hyprsunset
neovim
zathura
papirus-icon-theme
ttf-jetbrains-mono-nerd
```

---

## Wallpapers

Os wallpapers utilizados estão em:

```text
wallpapers/
```

---

## Scripts

A pasta `scripts/` contém pequenos utilitários para:

* trocar wallpaper
* controlar brilho
* controlar volume
* capturar screenshots
* iniciar aplicações
* atualizar configurações

---

## Observações

Estas configurações foram feitas para o meu ambiente de trabalho e podem não funcionar perfeitamente em outros computadores sem adaptações.

Sinta-se à vontade para reutilizar partes do projeto ou adaptá-las às suas necessidades.
