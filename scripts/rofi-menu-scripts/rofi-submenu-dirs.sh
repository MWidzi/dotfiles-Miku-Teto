#!/bin/bash

options="dotfiles\ncoding\n.config\nsystem trash"
selected=$(echo -e "$options" | rofi -dmenu)
cp ~/.config/alt_styles/rofi/normal/theme.rasi ~/.config/rofi/theme.rasi

case "$selected" in
    "dotfiles")
        kitty -d ~/.config ;;
    "coding")
        kitty -d ~/Documents/Programming ;;
    ".config")
        kitty -d ~/.config ;;
    "system trash")
        ~/.config/scripts/fileManager.sh ~/.local/share/Trash/files ;;
esac
