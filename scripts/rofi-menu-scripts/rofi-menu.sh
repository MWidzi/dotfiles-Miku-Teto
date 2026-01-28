#!/bin/bash

cp ~/.config/alt_styles/rofi/script_launcher/theme.rasi ~/.config/rofi/theme.rasi

options="pacman\naur\ndirectories\nnvim\nautism"
selected=$(echo -e "$options" | rofi -dmenu)
case "$selected" in
    "pacman")
        kitty --class floating-kitty ~/.config/scripts/rofi-menu-scripts/omarchy-pkg-install.sh ;;
    "aur")
        kitty --class floating-kitty ~/.config/scripts/rofi-menu-scripts/omarchy-pkg-aur-install.sh ;;
    "directories")
        ~/.config/scripts/rofi-menu-scripts/rofi-submenu-dirs.sh ;;
    "nvim")
        kitty sh -c "~/.config/scripts/rofi-menu-scripts/nvimWrapper.sh;" ;;
    "autism")
        ~/.config/scripts/rofi-menu-scripts/rofi-submenu-autism.sh ;;
esac

cp ~/.config/alt_styles/rofi/normal/theme.rasi ~/.config/rofi/theme.rasi
