---
sidebar_position: 2
title: Manage & Resume Sessions
description: "Save, resume, and manage AI coding sessions in AdaL. View session stats, token usage, and browse full conversation history in your browser."
---

# Manage & Resume Sessions

Track activity and resume previous conversations.

| Command | Description |
|---------|-------------|
| `/stats` | View current session stats |
| `/resume` | Browse and resume previous sessions |

## View Session Stats

```bash
/stats
```

Shows current session information:
- **Session ID** and **uptime**
- **Token usage**: context percentage, current/max tokens
- **Memory compaction**: trigger threshold, target reduction
- **History path**: Link to full HTML conversation log

![Session Stats Dialog](/img/features/session-stats.png)

## Resume Previous Sessions

```bash
/resume
```

Select any previous session and continue where you left off.

```
> Resume Session
Use ↑↓ arrows to navigate, enter to resume, esc to cancel.

1. ○ Implement billing dashboard (current)
   2 hours ago · 15 messages

2. ○ Fix authentication bug
   1 day ago · 8 messages
```

Each session shows:
- Last message preview
- Time ago
- Message count
- Current indicator

**Controls**: `↑/↓` navigate, `Enter` load, `ESC` cancel

After resuming, see session stats and a link to full HTML history:

```
✓ Session resumed · 10 messages loaded  
Full history: file:///path/to/session_x.html (copy to browser to open)
─────────────────────────────────────────────────────────────────────
```

## View Full History in Browser

Your terminal shows the last 10 messages to stay fast. To see everything, copy the file path and paste it into your browser for a beautifully formatted HTML view.

![Session History HTML View](/img/features/session-history-html.png)

**Benefits:**
- **Complete history** - See every message, tool call, and response
- **Syntax highlighting** - Code blocks with proper formatting
- **Searchable** - Find commands instantly with Cmd+F (macOS) or Ctrl+F (Windows/Linux)
- **Shareable** - Save or share the HTML file

Perfect for reviewing long sessions or documenting your workflow.

## What Gets Saved

- Full conversation (messages, tool calls, responses)
- Working context (files referenced, commands run)
- Session metadata (timestamps, message count)


**Related:** [Slash Commands](./slash-commands.md) · [Keyboard Shortcuts](./keyboard-shortcuts.md) · [Session Sharing](./session-sharing.md) · [Persistent Memory](./persistent-memory.md)
