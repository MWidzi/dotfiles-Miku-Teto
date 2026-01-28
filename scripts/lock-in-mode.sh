#!/bin/bash

output=$(hyprctl getoption decoration:active_opacity)

current_active_opacity=$(echo "$output" | grep "^float:" | awk '{print $2}')

opacity_on=1.000000
active_opacity_off=0.87
inactive_opacity_off=0.7
gaps_in_on=0
gaps_out_on=1,0,0,0
gaps_in_off=5
gaps_out_off=10,5,10,5
rounding_on=0
rounding_off=5

if [[ "$current_active_opacity" == "$opacity_on" ]]; then
    # Switch to "off" values
    hyprctl keyword animations:enabled yes
    hyprctl keyword decoration:active_opacity $active_opacity_off
    hyprctl keyword decoration:inactive_opacity $inactive_opacity_off
    hyprctl keyword general:gaps_in $gaps_in_off
    hyprctl keyword general:gaps_out $gaps_out_off
    hyprctl keyword decoration:rounding $rounding_off
    pkill waybar
    pkill cava
    cp ~/.config/alt_styles/waybar/normal/config.jsonc ~/.config/waybar/config.jsonc
    cp ~/.config/alt_styles/waybar/normal/style.css ~/.config/waybar/style.css
    waybar
else
    # Switch to "on" values
    hyprctl keyword animations:enabled no
    hyprctl keyword decoration:active_opacity $opacity_on
    hyprctl keyword decoration:inactive_opacity $opacity_on
    hyprctl keyword general:gaps_in $gaps_in_on
    hyprctl keyword general:gaps_out $gaps_out_on
    hyprctl keyword decoration:rounding $rounding_on
    pkill waybar
    pkill cava
    cp ~/.config/alt_styles/waybar/alt/config.jsonc ~/.config/waybar/config.jsonc
    cp ~/.config/alt_styles/waybar/alt/style.css ~/.config/waybar/style.css
    waybar
fi
