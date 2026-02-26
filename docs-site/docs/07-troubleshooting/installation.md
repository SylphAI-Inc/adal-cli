---
sidebar_position: 2
title: Installation
description: "Install AdaL CLI on macOS, Windows, or Linux. Requires Node.js 20+. Supports Apple Silicon, Intel, ARM64. Auto-updates included."
---

# Installation

> **TL;DR:** `npm install -g @sylphai/adal-cli` on macOS, Windows, or Linux ([Node.js 20+](https://nodejs.org/en/download) required)

## Installation Methods

This is the easiest and recommended way to install AdaL CLI.

### Global Installation (Recommended)

```bash
# Install globally
npm install -g @sylphai/adal-cli

# Verify installation
adal -v

# Start AdaL
adal
```

**Why global?**
- Available from any directory
- Simple `adal` command
- Automatic PATH configuration

## Updating AdaL

### Auto-Update (Default)

AdaL checks for updates every time you start a session. No action required—updates happen automatically. If a new version is available:
1. The update scheduled in the background
2. When you quit the session, the update is applied (takes a few seconds)
3. Next time you run `adal`, you'll have the latest version

### Manual Update

If auto-update fails, you can do manual update:

```bash
# Standard update
npm update -g @sylphai/adal-cli

# Or reinstall to latest
npm install -g @sylphai/adal-cli

# If permission denied, use sudo
sudo npm install -g @sylphai/adal-cli
```

## System Requirements

### Operating System

**✅ Supported Platforms:**

- **macOS:** 
  - Apple Silicon (M1/M2/M3/M4)
  - Intel (x64)
  - Requires macOS 10.15 Catalina or newer

- **Windows:**
  - 64-bit (x64) architecture
  - Windows 10 version 1903 or newer
  - Windows 11 (all versions)
  - Windows Server 2019 or newer

- **Linux:**
  - Ubuntu 18.10 or newer
  - Debian 10+ (Buster)
  - Fedora 29+
  - RHEL 8+, Rocky Linux 8+, AlmaLinux 8+
  - CentOS 8+
  - Amazon Linux 2023
  - **Requires GLIBC 2.28 or newer**

**❌ Not Supported:**
- Ubuntu 18.04 and older (GLIBC too old)
- RHEL 7 / CentOS 7 (EOL, GLIBC 2.17)
- macOS 10.14 Mojave and older
- Windows 7, 8, 8.1
- 32-bit systems

### Software Requirements

**Required:**

- **Node.js:** Version 20.0.0 or newer
  - Check: `node --version`
  - Download: [nodejs.org](https://nodejs.org/)

- **npm or yarn:** Package manager
  - npm comes with Node.js
  - Check: `npm --version`

**Recommended:**

- **Git:** For version control features
  - Check: `git --version`
  - Download: [git-scm.com](https://git-scm.com/)

- **Terminal:** Modern terminal emulator
  - macOS: Terminal.app or iTerm2
  - Windows: Windows Terminal (recommended), PowerShell, or CMD
  - Linux: GNOME Terminal, Konsole, or similar


### Hardware Requirements

**Minimum:**
- **RAM:** 4GB
- **Disk:** 500MB free space
- **CPU:** Any modern processor (x64 or ARM64)
- **Internet:** Required for cloud AI models

**Recommended:**
- **RAM:** 8GB or more
- **Disk:** 2GB+ free space
- **SSD:** For better performance
- **Internet:** Stable broadband connection


## Next Steps

✅ **Installation complete!** Now:

1. **[Quickstart →](../01-getting-started/quickstart.md)**  
   Start your first AdaL session in 5 minutes

2. **[Workflows & Examples →](../01-getting-started/workflows-and-examples.md)**  
   Learn practical development patterns


## Need Help?

If you encounter issues during installation:

1. **[GitHub Issues](https://github.com/SylphAI-Inc/adal-cli/issues)** - Report bugs or request features
2. **[Discord Community](https://discord.com/invite/ezzszrRZvT)** - Get help from the community
3. **Email Support:** contact@sylph.ai

**When reporting issues, include:**
- Operating system and version
- Node.js version (`node --version`)
- npm version (`npm --version`)
- Error messages (full output)
- Installation method used
