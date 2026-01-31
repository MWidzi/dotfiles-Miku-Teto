#!/bin/bash

cp ~/.config/alt_styles/rofi/script_launcher/theme.rasi ~/.config/rofi/theme.rasi

options="mikuteto\ninabashell"
selected=$(echo -e "$options" | rofi -dmenu)
case "$selected" in
    "mikuteto")
        sh -c "~/.config/scripts/rice_switcher/symlink_changer.sh ~/dotfiles-Miku-Teto" ;;
    "inabashell")
        sh -c "~/.config/scripts/rice_switcher/symlink_changer.sh ~/inabashell" ;;
esac

cp ~/.config/alt_styles/rofi/normal/theme.rasi ~/.config/rofi/theme.rasi
