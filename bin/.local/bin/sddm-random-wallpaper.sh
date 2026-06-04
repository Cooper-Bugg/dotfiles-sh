#!/bin/bash
# Picks a random wallpaper for SDDM that differs from the current desktop wallpaper.
# Run by systemd before sddm.service starts.
WALLPAPER_DIR="/home/cooper/media/images/wallpapers"
CACHE="/home/cooper/.cache/next-wallpaper"
TARGET="/usr/share/sddm/themes/silent/backgrounds/current.png"

CURRENT=$(cat "$CACHE" 2>/dev/null)

mapfile -t ALL < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \))

CANDIDATES=()
for wp in "${ALL[@]}"; do
    [[ "$wp" != "$CURRENT" ]] && CANDIDATES+=("$wp")
done

[[ ${#CANDIDATES[@]} -eq 0 ]] && CANDIDATES=("${ALL[@]}")
[[ ${#CANDIDATES[@]} -eq 0 ]] && exit 0

PICK="${CANDIDATES[RANDOM % ${#CANDIDATES[@]}]}"

[[ -n "$PICK" && -f "$PICK" ]] && cp "$PICK" "$TARGET"
