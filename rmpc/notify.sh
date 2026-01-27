#!/usr/bin/bash

TMP_DIR="/tmp/rmpc"
mkdir -p "$TMP_DIR"

ALBUM_ART_PATH="$TMP_DIR/notification_cover"
DEFAULT_ALBUM_ART_PATH="$TMP_DIR/default_album_art.jpg"

if ! rmpc albumart --output "$ALBUM_ART_PATH"; then
    ALBUM_ART_PATH="${DEFAULT_ALBUM_ART_PATH}"
fi

notify-send -i "${ALBUM_ART_PATH}" "Now Playing" "$ARTIST - $TITLE"
