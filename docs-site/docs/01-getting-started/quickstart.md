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

Open any terminal—macOS Terminal, Linux shell, or an IDE terminal like VS Code—then `cd` to your working directory and run:

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
| `Ctrl+P` | Toggle plan mode |
| `ESC` | Cancel/reject |
| `?` | Show all shortcuts |

## Essential Prefixes

| Prefix | What it does | Example |
|--------|--------------|---------|
| `@` | Target specific file as context | `@src/api.ts add validation` |
| `!` | Run shell command | `!npm test` |

---

## What's Next?

- **[Workflows & Examples →](./workflows-and-examples.md)** - Practical development patterns
- **[Slash Commands →](../03-features/slash-commands.md)** - All commands
- **[Keyboard Shortcuts →](../03-features/keyboard-shortcuts.md)** - Full reference
