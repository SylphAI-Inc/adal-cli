---
sidebar_position: 1
title: Quickstart
---

# Quickstart

Get AdaL running in 2 minutes.

## Install

```bash
npm install -g @sylphai/adal-cli
```

**Requires:** [Node.js 20+](https://nodejs.org/en/download) · [Installation help →](../07-troubleshooting/installation.md)

## Launch

Open any terminal (VS Code, iTerm, PowerShell, Linux shell, etc.) and then `cd` to your working directory and run:

```bash
adal
```

First run opens browser for authentication, then you're ready.

## Try It

```
> Hello, what can you help me with?

> Summarize the codebase

> /init
```


## Essential Commands

| Command | What it does |
|---------|--------------|
| `/help` | Show all commands |
| `/model` | Switch AI model |
| `/init` | Generate project context (AGENTS.md) |
| `/resume` | Resume a previous conversation |
| `/compact` | Compress memory when full |
| `/quit` | Exit |

## Workspace Management

Work on multiple branches in parallel:

| Command | What it does |
|---------|--------------|
| `adal workspace create <name>` | Create new workspace |
| `adal workspace list` | List all workspaces |
| `adal workspace remove <name>` | Remove workspace |

## Essential Shortcuts

| Shortcut | What it does |
|----------|--------------|
| `?` | Show all shortcuts |
| `Tab` | Toggle thinking mode |
| `Shift+Tab` | Toggle auto-accept edits |
| `Ctrl+P` | Toggle plan mode |
| `Ctrl+C` | Cancel agent streaming/running|
| `ESC` | Clear input |

## Essential Prefixes

| Prefix | What it does | Example |
|--------|--------------|---------|
| `@` | Target specific file as context | `@src/api.ts add validation` |
| `!` | Run shell command | `!git status` |

## Terminal Setup

**Recommended terminals:**
- **Native terminal** — macOS Terminal (macOS 26+), iTerm2, Windows Terminal, or your Linux terminal
- **VS Code integrated terminal** — Drag the terminal panel to the top-right corner for a wider, taller view

**Tip:** A larger terminal window gives AdaL more room to display code and diffs clearly.

### Truecolor Support

AdaL themes require **truecolor (24-bit color)** for accurate rendering. Most modern terminals support this by default.

**Check your terminal:**
```bash
echo $COLORTERM
```
Output should be `truecolor` or `24bit`.

**Enable truecolor:** Add to your shell profile (`.zshrc`, `.bashrc`):
```bash
export COLORTERM=truecolor
```

:::tip macOS Native Terminal
If colors appear off in the macOS Terminal app, upgrade to macOS 26+ for full truecolor support, or use iTerm2 / VS Code terminal instead.
:::

## What's Next?

- **[Workflows & Examples →](./workflows-and-examples.md)** - Practical development patterns
- **[Slash Commands →](../03-features/slash-commands.md)** - All commands
- **[Keyboard Shortcuts →](../03-features/keyboard-shortcuts.md)** - Full reference
