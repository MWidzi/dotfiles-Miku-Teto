#!/bin/bash

hyprshot -s -zm output -m "eDP-1" -o ~/Dotfiles/images -f "hyprlock_wallpaper.png"
powerprofilesctl set 'power-saver'
sleep 0.5
hyprlock
powerprofilesctl set 'balanced'
