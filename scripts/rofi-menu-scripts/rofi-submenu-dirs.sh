#!/bin/bash

options="dotfiles\ncoding\n.config\nsystem trash"
selected=$(echo -e "$options" | rofi -dmenu)
cp ~/Dotfiles/alt_styles/rofi/normal/theme.rasi ~/Dotfiles/rofi/theme.rasi

case "$selected" in
    "dotfiles")
        kitty -d ~/Dotfiles ;;
    "coding")
        kitty -d ~/Documents/Programming ;;
    ".config")
        kitty -d ~/.config ;;
    "system trash")
        ~/Dotfiles/scripts/fileManager.sh ~/.local/share/Trash/files ;;
esac
