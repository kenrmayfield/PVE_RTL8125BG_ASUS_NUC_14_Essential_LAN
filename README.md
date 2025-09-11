# Realtek r8125 Driver Installation Script

This script installs the latest Realtek r8125 driver provided by [awesometic](https://github.com/awesometic/realtek-r8125-dkms) on GitHub.  
I created this to get the Realtek RTL8125BG NIC working with Proxmox on my **ASUS NUC 14 Essential (90AR00M2-M00XXX)**.

## Prerequisites
You need an internet connection to download the driver package. If your NIC is not working yet, you can use:
- An external NIC / Dock (JSAUX Steam Deck Dock in my case)
- Preload the packages and dependencies beforehand
- Use the built-in WiFi (if available with your Device)

## Installation Steps

### 1. Install necessary dependencies and kernel headers
```sh
apt install -y dkms build-essential pve-headers-$(uname -r)
```

### 2. Download the latest Realtek r8125 driver package from GitHub
```sh
wget -qO- https://api.github.com/repos/awesometic/realtek-r8125-dkms/releases/latest \
  | grep -oP '(?<="browser_download_url": ")[^"]*amd64.deb' \
  | wget -i -
```

### 3. Install the downloaded driver package
```sh
dpkg -i realtek-r8125-dkms*.deb
```

### 4. Optionally blacklist the r8169 driver to prevent conflicts
```sh
echo "blacklist r8169" > /etc/modprobe.d/blacklist-r8169.conf
```

### 5. Update initramfs to apply changes
```sh
update-initramfs -u
```

### 6. Reboot the system
```sh
reboot now
```

---
After rebooting, your Realtek RTL8125BG NIC should be working. You can verify it using:
```sh
ip a
```
If you experience any issues, check the logs with:
```sh
dmesg | grep r8125
