---
sidebar_position: 1
title: Quickstart
description: "Install and start using AdaL AI coding agent in 2 minutes. Works in any terminal — VS Code, iTerm, macOS Terminal, PowerShell, or Linux shell."
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Quickstart

Get AdaL running in 2 minutes.

You can use AdaL in the terminal or via the Desktop app. Both give you access not only to the agent, but also to the agentic IDE for tasks that are either more visual or require a diff view. Quick setup in 2 minutes.

<video controls width="100%" style={{borderRadius: '8px', marginBottom: '1.5rem'}}>
  <source src="/video/install-tutorial.mp4" type="video/mp4" />
  Your browser does not support the video tag.
</video>

## Step 1: Install

Open any terminal — we recommend iTerm2 terminal. macOS native Terminal requires macOS 26+ for full theme support. For more details, see [Terminal Setup](#terminal-setup).

<Tabs groupId="install-method">
  <TabItem value="native" label="Native Install (Recommended)" default>

```bash
curl -fsSL https://adal.sylph.ai/install.sh | bash
```

Native install works on macOS, Linux, and WSL. For other platforms (e.g., Windows PowerShell), use the npm install.

  </TabItem>
  <TabItem value="npm" label="npm">

```bash
npm install -g @sylphai/adal-cli
```

Requires [Node.js 20+](https://nodejs.org/en/download).

  </TabItem>
</Tabs>

## Step 2: Launch

Go to your working directory and run:

```bash
adal
```

First run opens browser for authentication, then you're ready.

## Step 3: Try It

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

## Essential Shortcuts

| Shortcut | What it does |
|----------|--------------|
| `?` | Show all shortcuts |
| `Tab` | Toggle mode: Regular → Plan → Deep Research |
| `Shift+Tab` | Toggle auto-accept edits |
| `Ctrl+C` | Cancel agent streaming/running|
| `ESC` | Clear input |

## Essential Prefixes

| Prefix | What it does | Example |
|--------|--------------|---------|
| `@` | Target specific file as context | `@src/api.ts add validation` |
| `!` | Run shell command | `!git status` |

## Worktree Management

Work on multiple branches in parallel:

| Command | What it does |
|---------|--------------|
| `adal worktree create -b <name>` | Create new worktree from main |
| `adal worktree create -b <name> <start-point>` | Create from specific branch |
| `adal worktree list` | List all worktrees |
| `adal worktree delete <name>` | Delete worktree |

## Terminal Setup

**Recommended terminals:**
- **Native terminal** — macOS Terminal (macOS 26+), iTerm2, cmux, Windows Terminal, or Linux terminal
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
