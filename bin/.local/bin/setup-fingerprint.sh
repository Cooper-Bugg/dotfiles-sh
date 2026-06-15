#!/bin/bash
# Fingerprint scanner setup for ThinkPad T480
# Device: Synaptics Metallica MIS (06cb:009a)
# Run this once sudo is working: bash ~/.local/bin/setup-fingerprint.sh

set -e

echo "=== ThinkPad T480 Fingerprint Setup ==="
echo "Device: Synaptics Metallica MIS (06cb:009a)"
echo ""

# Step 1: Install fprintd
echo "[1/4] Installing fprintd..."
sudo pacman -S --noconfirm fprintd

# Step 2: Check if standard libfprint supports the device
echo "[2/4] Checking device support..."
if sudo fprintd-enroll -f left-index-finger 2>&1 | grep -q "No devices available\|not found"; then
    echo "Standard libfprint doesn't see the device."
    echo "Installing Synaptics TOD driver from AUR..."
    paru -S --noconfirm libfprint-2-tod1-synaptics
    echo "Restart fprintd service after TOD install:"
    echo "  sudo systemctl restart fprintd"
fi

# Step 3: Enable fprintd service
echo "[3/4] Enabling fprintd..."
sudo systemctl enable --now fprintd

# Step 4: Configure PAM for sudo fingerprint auth
echo "[4/4] Configuring PAM..."
# Add fingerprint auth to system-auth BEFORE the password line
if ! grep -q "pam_fprintd" /etc/pam.d/system-auth; then
    sudo sed -i 's/^auth       \[success=1 default=bad\]     pam_unix.so/auth       sufficient                  pam_fprintd.so\nauth       [success=1 default=bad]     pam_unix.so/' /etc/pam.d/system-auth
    echo "PAM configured."
else
    echo "PAM already has fingerprint entry."
fi

echo ""
echo "=== Enroll your fingerprint ==="
echo "Run: fprintd-enroll"
echo "Follow prompts for left-index-finger (or whichever you prefer)."
echo ""
echo "=== SDDM fingerprint login ==="
echo "If you want fingerprint at the login screen, also run:"
echo "  sudo sed -i 's/^auth.*pam_unix.so/auth sufficient pam_fprintd.so\n&/' /etc/pam.d/sddm"
echo ""
echo "Done. Test sudo with fingerprint: sudo whoami"
