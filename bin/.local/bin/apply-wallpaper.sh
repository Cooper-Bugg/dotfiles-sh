#!/bin/bash
# Runs on Hyprland startup -- applies the wallpaper selected at last shutdown

LOCK_FILE="$HOME/.cache/wallpaper-locked"
STATE_FILE="$HOME/.cache/wallpaper-lock-state"

if [[ -f "$LOCK_FILE" && -f "$STATE_FILE" ]]; then
    # Restore the locked wallpapers exactly
    while IFS= read -r line; do
        mon=$(echo "$line" | cut -d':' -f1)
        wall=$(echo "$line" | cut -d':' -f2-)
        if [[ -n "$mon" && -f "$wall" ]]; then
            awww img -o "$mon" "$wall"
        fi
    done < "$STATE_FILE"
    exit 0
fi

CACHE="$HOME/.cache/next-wallpaper"
DEFAULT="$HOME/media/images/wallpapers/island-night.png"
DIR="$HOME/media/images/wallpapers"

WALLPAPER=$(cat "$CACHE" 2>/dev/null)

if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
    WALLPAPER="$DEFAULT"
fi

# Get all connected monitors
MONITORS=$(awww query | awk -F':' '{print $2}' | tr -d ' ')

first=true
for mon in $MONITORS; do
    if [ "$first" = true ]; then
        awww img -o "$mon" "$WALLPAPER"
        first=false
    else
        # Select a random wallpaper different from the primary one
        OTHER_WALL=$(find "$DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | grep -v "$WALLPAPER" | shuf -n1)
        if [ -n "$OTHER_WALL" ]; then
            awww img -o "$mon" "$OTHER_WALL"
        fi
    fi
done

echo "$WALLPAPER" > "$HOME/.cache/current-wallpaper"

