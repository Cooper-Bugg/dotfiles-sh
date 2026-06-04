#!/bin/bash
# Runs on Hyprland startup -- applies the wallpaper selected at last shutdown
CACHE="$HOME/.cache/next-wallpaper"
DEFAULT="$HOME/media/images/wallpapers/island-night.png"

WALLPAPER=$(cat "$CACHE" 2>/dev/null)

if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
    WALLPAPER="$DEFAULT"
fi

awww img "$WALLPAPER"
echo "$WALLPAPER" > "$HOME/.cache/current-wallpaper"
