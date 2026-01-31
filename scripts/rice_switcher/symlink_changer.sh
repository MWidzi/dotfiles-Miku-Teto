#!/bin/bash

rice_path="$1"

find ~/.config -type l -delete

mapfile -t dirs < <(find "$rice_path" -mindepth 1 -maxdepth 1 -type d)

declare -a filtered_dirs=()

for dir in "${dirs[@]}"; do
  basename_dir=$(basename "$dir")
  if [[ ! "$basename_dir" =~ ^(Discord|firefox|screenshots|\.git)$ ]]; then
    filtered_dirs+=("$dir")
  fi
done

config_base="$HOME/.config"
for dir in "${filtered_dirs[@]}"; do
  dir_name=$(basename "$dir")
  target="$config_base/$dir_name"
  ln -sfn "$dir" "$target"
done

hyprctl reload
