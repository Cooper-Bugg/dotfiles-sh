#!/bin/bash
# Runs on shutdown -- picks a random wallpaper so the next boot is different
WALLPAPER_DIR="$HOME/media/images/wallpapers"
CACHE="$HOME/.cache/next-wallpaper"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n1)

if [[ -n "$WALLPAPER" && -f "$WALLPAPER" ]]; then
    echo "$WALLPAPER" > "$CACHE"
fi
