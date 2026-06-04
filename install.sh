#!/bin/bash
# Symlink all dotfile packages using stow
# Run from ~/.dotfiles after cloning

DOTFILES="$HOME/.dotfiles"
PACKAGES=(hypr waybar rofi nvim zsh kitty bin misc)

for pkg in "${PACKAGES[@]}"; do
    echo "stowing $pkg..."
    stow -d "$DOTFILES" -t "$HOME" "$pkg"
done

echo "done"
