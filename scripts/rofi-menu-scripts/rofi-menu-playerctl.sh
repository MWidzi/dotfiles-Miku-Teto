#!/bin/bash

cp ~/.config/alt_styles/rofi/playerctl_menu/theme.rasi ~/.config/rofi/theme.rasi

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

cp ~/.config/alt_styles/rofi/normal/theme.rasi ~/.config/rofi/theme.rasi
