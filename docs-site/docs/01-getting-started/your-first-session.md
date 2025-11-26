---
sidebar_position: 2
title: Quickstart
---

# Quickstart

Get AdaL running in 2 minutes.

## Install

```bash
npm install -g @sylphai/adal-cli
```

**Requires:** Node.js 20+ · [Detailed installation →](../07-troubleshooting/installation.md)

## Launch

```bash
cd your-project
adal
```

First run opens browser for authentication, then you're ready.

## Try It

```
> Hello, what can you help me with?

> Create a simple REST endpoint for user registration

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

- **[Project Walkthrough →](./project-walkthrough.md)** - Complete feature lifecycle
- **[Slash Commands →](../08-reference/slash-commands.md)** - All commands
- **[Keyboard Shortcuts →](../08-reference/keyboard-shortcuts.md)** - Full reference
