---
sidebar_position: 1
title: Keyboard Shortcuts
---

# Keyboard Shortcuts

Quick reference for all keyboard shortcuts in AdaL CLI.

## Input Editing

| Shortcut | Action |
|----------|--------|
| `Ctrl+A` | Move cursor to start of line |
| `Ctrl+E` | Move cursor to end of line |
| `Ctrl+U` | Clear from start to cursor |
| `Ctrl+K` | Clear from cursor to end |
| `Ctrl+W` | Delete word before cursor |
| `Ctrl+L` | Clear screen (display only) |

## History Navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl+P` or `↑` | Previous command in history |
| `Ctrl+N` or `↓` | Next command in history |
| `Ctrl+R` | Search command history |

## During Agent Response

| Shortcut | Action |
|----------|--------|
| `ESC` | Cancel/interrupt current response |
| `Ctrl+C` | Force stop agent |

## Modes & Toggles

| Shortcut | Action |
|----------|--------|
| `Tab` | Toggle thinking mode (extended reasoning) |
| `Shift+Tab` | Toggle auto-accept edit mode |
| `Ctrl+R` | Expand/collapse thinking content |
| `?` | Toggle shortcuts display in footer |

## Tool Confirmation

When AdaL shows a tool confirmation prompt:

| Shortcut | Action |
|----------|--------|
| `Enter` or `1` | Accept (allow once) |
| `Shift+Tab` or `2` | Always allow this session |
| `ESC` or `3` | Reject and ask for alternative |
| `↑` / `↓` | Navigate options |

## Autocomplete

| Shortcut | Action |
|----------|--------|
| `Tab` | Accept suggestion / cycle options |
| `ESC` | Cancel suggestions |

---

## Mode Explanations

### Thinking Mode (`Tab`)

When enabled, AdaL shows its reasoning process:

```
[Thinking mode: ON]

> How should I structure this authentication system?

<thinking>
- Need to consider security best practices
- JWT vs session tokens
- Password hashing algorithm choice
- Rate limiting for login attempts
</thinking>

Here's my recommendation...
```

**When to enable:**
- Complex architectural decisions
- Debugging tricky issues
- Performance optimization

### Auto-Accept Mode (`Shift+Tab`)

When enabled, file edits are applied automatically without confirmation:

```
[Auto-accept: ON]

> Add error handling to all API endpoints

✓ Edited src/api/users.ts
✓ Edited src/api/products.ts
✓ Edited src/api/orders.ts
```

**Use carefully:** Only enable when you trust the changes.

---

**Related:** [Slash Commands](./slash-commands.md) · [Workflows & Examples](../01-getting-started/workflows-and-examples.md)

