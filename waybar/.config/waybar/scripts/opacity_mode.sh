#!/bin/bash
STATE="$HOME/.local/share/opacity-mode"
MODE=$(cat "$STATE" 2>/dev/null || echo "normal")

if [[ "$MODE" == "100" ]]; then
    echo '{"text": "󰈈", "tooltip": "100% opacity — click for normal transparency", "class": "full"}'
else
    echo '{"text": "󰈉", "tooltip": "Normal transparency — click for 100% opacity", "class": "normal"}'
fi
