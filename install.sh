#!/bin/bash
set -e

THEME_DIR="/usr/share/sddm/themes/magi"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "MAGI Login System — Installer"
echo "=============================="

# Check dependencies
if ! command -v sddm &> /dev/null; then
    echo "Error: sddm not found. Install with: sudo pacman -S sddm"
    exit 1
fi

# Create theme directory
echo "Installing theme to $THEME_DIR..."
sudo mkdir -p "$THEME_DIR"

# Copy files
sudo cp -r "$SCRIPT_DIR"/Main.qml "$SCRIPT_DIR"/metadata.desktop "$SCRIPT_DIR"/theme.conf "$THEME_DIR/"
sudo cp -r "$SCRIPT_DIR"/components "$THEME_DIR/"
sudo cp -r "$SCRIPT_DIR"/assets "$THEME_DIR/"

# Set permissions
sudo chmod -R 755 "$THEME_DIR"

# Configure SDDM
echo "Setting MAGI as default theme..."
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=magi" | sudo tee /etc/sddm.conf.d/99-magi.conf > /dev/null

echo ""
echo "Installation complete!"
echo "Restart SDDM or reboot to see the new theme."
echo ""
echo "To uninstall: sudo rm -rf $THEME_DIR /etc/sddm.conf.d/99-magi.conf"
