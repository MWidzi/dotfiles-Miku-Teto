#!/bin/bash

options="dotfiles\ncoding\n.config\nsystem trash"
selected=$(echo -e "$options" | rofi -dmenu)
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
