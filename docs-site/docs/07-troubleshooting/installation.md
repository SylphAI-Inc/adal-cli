---
sidebar_position: 2
title: Installation
---

# Installation

> **TL;DR:** `npm install -g @sylphai/adal-cli` on macOS, Windows, or Linux (Node.js 20+ required)

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
  - Ubuntu 22.04 LTS or newer
  - Debian 12+ (Bookworm)
  - Fedora 36+
  - RHEL 9+, Rocky Linux 9+, AlmaLinux 9+
  - Amazon Linux 2023
  - **Requires GLIBC 2.35 or newer**

**❌ Not Supported:**
- Ubuntu 20.04 and older (GLIBC too old)
- macOS 10.14 Mojave and older
- Windows 7, 8, 8.1
- 32-bit systems

### Software Requirements

**Required:**

- **Node.js:** Version 20.0.0 or newer
  - Check: `node --version`
  - Download: [nodejs.org](https://nodejs.org/)
  - Recommended: Use LTS version (currently 20.x)

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

---

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




## Next Steps

✅ **Installation complete!** Now:

1. **[Quickstart →](../01-getting-started/your-first-session.md)**  
   Start your first AdaL session in 5 minutes

2. **[Workflows & Examples →](../01-getting-started/workflows-and-examples.md)**  
   Learn practical development patterns

---

## Need Help?

If you encounter issues during installation:

1. **[Getting Started →](../01-getting-started/your-first-session.md)** - Start using AdaL CLI
2. **[Features →](../03-features/slash-commands.md)** - Complete feature reference
3. **[Discord Community](https://discord.com/invite/ezzszrRZvT)** - Get help from the community
4. **Email Support:** contact@sylph.ai

**When reporting issues, include:**
- Operating system and version
- Node.js version (`node --version`)
- npm version (`npm --version`)
- Error messages (full output)
- Installation method used
