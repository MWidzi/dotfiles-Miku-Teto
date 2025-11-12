#!/bin/bash

cp ~/Dotfiles/alt_styles/rofi/playerctl_menu/theme.rasi ~/Dotfiles/rofi/theme.rasi

options="\n\n"
selected=$(echo -e "$options" | rofi -dmenu)
case "$selected" in
    "")
        playerctl previous ;;
    "")
        playerctl play-pause ;;
    "")
        playerctl next ;;
esac

cp ~/Dotfiles/alt_styles/rofi/normal/theme.rasi ~/Dotfiles/rofi/theme.rasi
