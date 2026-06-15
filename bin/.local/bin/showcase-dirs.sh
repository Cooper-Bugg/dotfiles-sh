#!/bin/bash
# Showcase directories in /home/cooper with icons and colors
# Uses 'eza' for better visualization as mentioned in fastfetch config

COLOR_TITLE="\e[38;2;0;215;255m"
COLOR_SEP="\e[38;2;90;159;212m"
COLOR_RESET="\e[0m"

echo -e "${COLOR_TITLE}Cooper's Home Directory Showcase${COLOR_RESET}"
echo -e "${COLOR_SEP}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${COLOR_RESET}"

if command -v eza &> /dev/null; then
    eza --icons --group-directories-first -D --color=always /home/cooper | grep -v "^\."
else
    ls -d /home/cooper/*/ | xargs -n 1 basename | sed 's/^/  📁 /'
fi

echo -e "${COLOR_SEP}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${COLOR_RESET}"
