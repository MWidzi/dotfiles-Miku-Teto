#!/bin/bash

percent=$(upower --battery | grep 'percentage' | awk '{print $NF;}')
number=${percent%\%}

charging=$(upower --battery | grep 'state' | awk '{print $NF;}')

if [[ "$charging" == "charging" ]] then
    icon=""
elif [ "$number" -lt 20 ]; then
    icon=" "
elif [ "$number" -lt 40 ]; then
    icon=" "
elif [ "$number" -lt 60 ]; then
    icon=" "
elif [ "$number" -lt 80 ]; then
    icon=" "
elif [ "$number" -lt 100 ]; then
    icon=" "
fi

echo "$icon $percent"
