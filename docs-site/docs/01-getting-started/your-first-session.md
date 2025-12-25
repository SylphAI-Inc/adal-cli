---
sidebar_position: 0
title: Quickstart
slug: /
---

# Quickstart

Get AdaL running in 2 minutes.

## Install

```bash
npm install -g @sylphai/adal-cli
```

**Requires:** Node.js 20+ · [Detailed installation →](../07-troubleshooting/installation.md)

## Launch

Open any terminal—macOS Terminal, Linux shell, or an IDE terminal like VS Code—then `cd` to your working directory and run:

```bash
adal
```

First run opens browser for authentication, then you're ready.

## Try It

```
> Hello, what can you help me with?

> Summarize the codebase or run /init to create AGENTS.md

> @src/server.ts Add error handling to this file
```

---

## Essential Commands

| Command | What it does |
|---------|--------------|
| `/help` | Show all commands |
| `/model` | Switch AI model |
| `/init` | Generate project context (AGENTS.md) |
| `/clear` | Clear conversation |
| `/compact` | Compress memory when full |
| `/quit` or `Ctrl+C` | Exit |

## Essential Shortcuts

| Shortcut | What it does |
|----------|--------------|
| `Tab` | Toggle thinking mode |
| `Shift+Tab` | Toggle auto-accept edits |
| `ESC` | Cancel/reject |
| `?` | Show all shortcuts |

## Essential Prefixes

| Prefix | What it does | Example |
|--------|--------------|---------|
| `@` | Target specific file | `@src/api.ts add validation` |
| `!` | Run shell command | `!npm test` |

---

## What's Next?

- **[Workflows & Examples →](./workflows-and-examples.md)** - Practical development patterns
- **[Slash Commands →](../03-features/slash-commands.md)** - All commands
- **[Keyboard Shortcuts →](../03-features/keyboard-shortcuts.md)** - Full reference
