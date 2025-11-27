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

**Optional:**

- **Python 3.11-3.14:** Backend auto-installs if needed
- **Ollama:** For local AI models (offline mode)

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

### Method 1: npm (Recommended)

This is the easiest and recommended way to install AdaL CLI.

#### Global Installation (Recommended)

```bash
# Install globally
npm install -g @sylphai/adal-cli

# Verify installation
adal --version
# Output: 0.2.0

# Start AdaL
adal
```

**Why global?**
- Available from any directory
- Simple `adal` command
- Automatic PATH configuration

#### Local Installation (Alternative)

Install in a specific project:

```bash
# Navigate to project
cd ~/projects/my-app

# Install locally
npm install @sylphai/adal-cli

# Run via npx
npx adal

# Or add to package.json scripts
# "scripts": { "adal": "adal" }
npm run adal
```


## Post-Installation Setup

### 1. Verify Backend Auto-Spawn

AdaL CLI auto-spawns a Python backend on first run. Verify it works:

```bash
# Start AdaL
adal

# You should see:
# 🚀 Starting backend on port 41230...
# ⏳ Initializing tools and services...
# ✅ Backend ready (took 2.3s)
#
# AdaL CLI v0.2.0
# Type /help for commands
```

**What happens:**
1. CLI checks ports 41230-41250 for availability
2. Spawns Python backend process (PyInstaller bundle)
3. Backend initializes tools (file ops, bash, MCP)
4. Health check confirms backend is ready
5. WebSocket connection established

**If backend fails to start:** See [Troubleshooting](#troubleshooting-installation) below.

### 2. Authenticate

On first run, you'll be prompted to log in:

```bash
adal

# Output:
# 🔐 Authentication required
# Opening browser for login...
#
# [Browser opens with OAuth login page]
# [Log in with Google, GitHub, or email]
#
# ✅ Authentication successful
# Welcome, user@example.com!
```

**What happens:**
1. CLI opens browser to Clerk OAuth page
2. You log in with preferred method
3. JWT token issued and stored securely in CLI
4. Token used for all backend ↔ cloud communication

**Stored:**
- Token location: `~/.adal/auth.json` (encrypted)
- Never stored in environment variables
- Never committed to git

### 3. Test Installation

Verify everything works:

```bash
# Quick test query
adal --question "Hello, AdaL!"

# Should respond with:
# Hello! I'm AdaL, your AI development assistant.
# How can I help you today?
```

**Success indicators:**
- Backend starts without errors
- Authentication completes
- Test query gets response
- No permission errors

---

## Platform-Specific Notes

### macOS

#### Gatekeeper Warning

If you see **"AdaL cannot be opened because the developer cannot be verified":**

**Solution 1: Remove quarantine attribute**
```bash
xattr -cr /usr/local/bin/adal
```

**Solution 2: System Preferences**
1. System Preferences → Security & Privacy
2. Click "Open Anyway" for AdaL
3. Restart terminal

#### Rosetta 2 (Apple Silicon)

AdaL uses native ARM64 binaries—no Rosetta needed. If you see x86_64 warnings:

```bash
# Check architecture
file $(which adal)
# Should show: Mach-O 64-bit executable arm64
```

#### Homebrew Permissions

If npm install fails with permission errors:

```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) $(brew --prefix)/*

# Retry install
npm install -g @sylphai/adal-cli
```

---

### Windows

#### Antivirus / SmartScreen

Some antivirus software may flag AdaL. This is a **false positive**.

**Solution: Add exception for:**
```
C:\Users\<username>\AppData\Roaming\npm\node_modules\@sylphai\adal-cli
```

**Windows Defender SmartScreen:**
1. Click "More info" on warning
2. Click "Run anyway"

#### PowerShell Execution Policy

If scripts won't run:

```powershell
# Check current policy
Get-ExecutionPolicy

# If Restricted, change to RemoteSigned
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Verify
Get-ExecutionPolicy
# Should show: RemoteSigned
```

#### Path Not Found

If `adal` command not found after npm install:

**Check npm global bin directory:**
```powershell
npm config get prefix
# Output: C:\Users\<username>\AppData\Roaming\npm
```

**Add to PATH:**
```powershell
# Temporary (current session)
$env:Path += ";$env:APPDATA\npm"

# Permanent (all sessions)
[Environment]::SetEnvironmentVariable(
    "Path",
    $env:Path + ";$env:APPDATA\npm",
    [EnvironmentVariableTarget]::User
)
```

Restart PowerShell and try again.

#### Windows Terminal (Recommended)

For best experience, use [Windows Terminal](https://aka.ms/terminal) instead of CMD/PowerShell:

- Better Unicode support
- Emoji rendering
- Split panes
- Themes

```powershell
# Install via winget
winget install Microsoft.WindowsTerminal
```

---

### Linux

#### Permission Denied (npm install)

**Problem:** `EACCES` error when installing globally

**Solution 1: Change npm prefix (Recommended)**
```bash
# Create directory for global packages
mkdir ~/.npm-global

# Configure npm to use it
npm config set prefix '~/.npm-global'

# Add to PATH
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install AdaL
npm install -g @sylphai/adal-cli
```

**Solution 2: Use sudo (Not Recommended)**
```bash
sudo npm install -g @sylphai/adal-cli
```

#### GLIBC Version Check

AdaL requires GLIBC 2.35+. Check your version:

```bash
ldd --version
# First line shows version: ldd (Ubuntu GLIBC 2.35-0ubuntu3.8) 2.35
```

**If too old (< 2.35):**

**Option 1: Upgrade distro** (Recommended)
```bash
# Ubuntu
sudo do-release-upgrade

# Debian
sudo apt update && sudo apt upgrade
```

**Option 2: Use Docker** (Alternative)
```bash
# Pull AdaL Docker image
docker pull sylphai/adal-cli:latest

# Run in container
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  sylphai/adal-cli
```

#### Missing Dependencies

If you see "error while loading shared libraries":

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y \
  libstdc++6 \
  libc6 \
  libgcc1 \
  ca-certificates

# Fedora/RHEL/Rocky
sudo dnf install -y \
  libstdc++ \
  glibc \
  ca-certificates
```

#### SELinux (Fedora/RHEL/Rocky)

If SELinux blocks execution:

```bash
# Check SELinux status
getenforce
# If Enforcing:

# Option 1: Add exception for AdaL
sudo chcon -t bin_t /usr/local/bin/adal

# Option 2: Temporarily disable (not recommended)
sudo setenforce 0
```

---

---

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
