#!/bin/bash

# Install necessary dependencies and kernel headers
apt install -y dkms build-essential pve-headers-$(uname -r)

# Download the latest Realtek r8125 driver package from GitHub
wget -qO- https://api.github.com/repos/awesometic/realtek-r8125-dkms/releases/latest | 
  grep -oP '(?<="browser_download_url": ")[^"]*amd64.deb' | 
  wget -i -

# Install the downloaded driver package
dpkg -i realtek-r8125-dkms*.deb

# Optionally blacklist the r8169 driver to prevent conflicts
echo "blacklist r8169" > /etc/modprobe.d/blacklist-r8169.conf

# Update the initramfs to apply changes
update-initramfs -u

echo "Installation complete! Please reboot your system."
