#!/bin/bash

options="all\ncava\npipes.sh\nbonsai.sh"
selected=$(echo -e "$options" | rofi -dmenu)

move_focused_window_relative() {
    dx=$1
    dy=$2
    hyprctl dispatch moveactive $dx $dy
}

focus_window() {
    address=$1
    hyprctl dispatch focuswindow address:$address
}

launch_and_random_quadrant_move() {
    cmd=$1
    quadrant=$2
    kitty --class small-floating-kitty $cmd &
    sleep 0.6

    address=$(hyprctl -j clients | jq -r '.[] | select(.class=="small-floating-kitty") | .address' | tail -n1)
    focus_window $address
    sleep 0.1

    screen_width=$(hyprctl monitors -j | jq '.[0].width')
    screen_height=$(hyprctl monitors -j | jq '.[0].height')

    # Window size set as 50%, calculate half window dims
    window_width=$((screen_width / 2))
    window_height=$((screen_height / 2))

    # Calculate max dx and dy so window stays fully onscreen
    max_dx=$((screen_width - window_width))
    max_dy=$((screen_height - window_height))

    # Set min offset padding to avoid touching edges
    padding_x=$((window_width / 4))
    padding_y=$((window_height / 4))

    # Random offset within quadrant range, constrained by padding
    range_dx=$((max_dx / 2 - padding_x))
    range_dy=$((max_dy / 2 - padding_y))

    random_x=$(( (RANDOM % range_dx) + padding_x ))
    random_y=$(( (RANDOM % range_dy) + padding_y ))

    case $quadrant in
        1) dx=$((-random_x)) ; dy=$((-random_y)) ;; # top-left
        2) dx=$random_x    ; dy=$((-random_y)) ;; # top-right
        3) dx=$((-random_x)); dy=$random_y    ;; # bottom-left
        4) dx=$random_x    ; dy=$random_y    ;; # bottom-right
        *) dx=$((RANDOM % max_dx - max_dx / 2))
           dy=$((RANDOM % max_dy - max_dy / 2)) ;;
    esac

    move_focused_window_relative $dx $dy
}

case "$selected" in
    "all")
        launch_and_random_quadrant_move "cava" 1
        launch_and_random_quadrant_move "bonsai.sh -l -i" 2
        launch_and_random_quadrant_move "pipes.sh" 3
        ;;
    "cava")
        launch_and_random_quadrant_move "cava" $(( (RANDOM % 4) + 1 ))
        ;;
    "pipes.sh")
        launch_and_random_quadrant_move "pipes.sh" $(( (RANDOM % 4) + 1 ))
        ;;
    "bonsai.sh")
        launch_and_random_quadrant_move "bonsai.sh -l -i" $(( (RANDOM % 4) + 1 ))
        ;;
esac
