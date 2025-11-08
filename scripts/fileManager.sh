#!/bin/bash

if [ -z "$1" ]; then
    kitty bash -c '
      kitty @ set-background-opacity 1.0
      yazi
      kitty @ set-background-opacity 0.7
    ' bash
else 
    kitty -d "$1" bash -c '
      kitty @ set-background-opacity 1.0
      yazi
      kitty @ set-background-opacity 0.7
    ' bash
fi
