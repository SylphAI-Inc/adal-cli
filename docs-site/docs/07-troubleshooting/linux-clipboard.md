---
title: Copy/Paste Not Working on Linux
sidebar_position: 1
description: "Install clipboard packages so copy/paste works reliably with AdaL on Linux."
---

# Copy/Paste Not Working on Linux

To make copy and paste work reliably with AdaL on Linux, you need to install a system clipboard utility. The package you need depends on whether you are using Wayland or X11. 

AdaL will automatically detect your environment and use the appropriate tool.

### For Wayland Systems

Install `wl-clipboard`:

- **Ubuntu / Debian:** `sudo apt install -y wl-clipboard`
- **Fedora:** `sudo dnf install -y wl-clipboard`
- **Arch Linux:** `sudo pacman -S wl-clipboard`

### For X11 Systems

Install `xclip` (or `xsel`):

- **Ubuntu / Debian:** `sudo apt install -y xclip`
- **Fedora:** `sudo dnf install -y xclip`
- **Arch Linux:** `sudo pacman -S xclip`

## Verify

After installing the appropriate package for your system, restart your terminal and run `adal` again.