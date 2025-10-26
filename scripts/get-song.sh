#!/bin/bash

player=$(playerctl metadata --all-players --format '{{ playerName }}' | head -n 1)
playing=$(playerctl --player="$player" status)

if [[ "$1" == "wb" ]]; then 
    text=$(playerctl metadata --all-players --format '  |  {{ artist }}' | head -n 1)
else 
    text=$(playerctl metadata --all-players --format '  |  {{ artist }} - {{ title }}' | head -n 1)
fi

if [[ "$player" == "" ]]; then
   exit 0 
elif [[ "$player" == "spotify" ]]; then
    playerIcon="  "
elif [[ "$player" == "firefox" ]]; then
    playerIcon="󰈹  "
else
    playerIcon="󰎆  "
fi

if [[ "$playing" == "Paused" ]]; then
    icon="▶"
else
    icon="⏸"
fi

echo "$playerIcon$icon$text"
