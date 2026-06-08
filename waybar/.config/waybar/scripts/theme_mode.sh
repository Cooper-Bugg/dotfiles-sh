#!/bin/bash
STATE="$HOME/.local/share/theme-mode"
MODE=$(cat "$STATE" 2>/dev/null || echo "dark")

if [[ "$MODE" == "light" ]]; then
    echo '{"text": "☀", "tooltip": "Light mode — click for dark", "class": "light"}'
else
    echo '{"text": "☾", "tooltip": "Dark mode — click for light", "class": "dark"}'
fi
