#!/bin/bash

hyprshot -s -zm output -m "DP-3" -o ~/Dotfiles/images -f "hyprlock_wallpaper2.png" &
hyprshot -s -zm output -m "DP-1" -o ~/Dotfiles/images -f "hyprlock_wallpaper.png" &
hyprshot -s -zm output -m "HDMI-A-1" -o ~/Dotfiles/images -f "hyprlock_wallpaper3.png" &
powerprofilesctl set 'power-saver' &

wait

sleep 1.1
hyprlock
powerprofilesctl set 'balanced'
