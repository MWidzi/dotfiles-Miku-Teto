#!/bin/bash

cp ~/Dotfiles/alt_styles/rofi/script_launcher/theme.rasi ~/Dotfiles/rofi/theme.rasi

options="pacman\naur\ndirectories\nnvim\nautism"
selected=$(echo -e "$options" | rofi -dmenu)
case "$selected" in
    "pacman")
        kitty --class floating-kitty ~/Dotfiles/scripts/rofi-menu-scripts/omarchy-pkg-install.sh ;;
    "aur")
        kitty --class floating-kitty ~/Dotfiles/scripts/rofi-menu-scripts/omarchy-pkg-aur-install.sh ;;
    "directories")
        ~/Dotfiles/scripts/rofi-menu-scripts/rofi-submenu-dirs.sh ;;
    "nvim")
        kitty sh -c "~/Dotfiles/scripts/rofi-menu-scripts/nvimWrapper.sh;" ;;
    "autism")
        ~/Dotfiles/scripts/rofi-menu-scripts/rofi-submenu-autism.sh ;;
esac

cp ~/Dotfiles/alt_styles/rofi/normal/theme.rasi ~/Dotfiles/rofi/theme.rasi
