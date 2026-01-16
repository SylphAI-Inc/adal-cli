---
sidebar_position: 1
title: Keyboard Shortcuts
---

# Keyboard Shortcuts

Quick reference for all keyboard shortcuts in AdaL CLI.

## Input Editing

| Shortcut | Action                       |
| -------- | ---------------------------- |
| `\+Enter` or `Shift+Enter` (Mac VS Code terminal) | Start a newline  |
| `ESC`    | Clear input                       |
| `Ctrl+L` | Clear screen but keep conversation memory  |
| `Ctrl+A` | Move cursor to start of line |
| `Ctrl+E` | Move cursor to end of line   |
| `Ctrl+U` | Clear from start to cursor   |
| `Ctrl+K` | Clear from cursor to end     |

## History Navigation

| Shortcut | Action                  |
| -------- | ----------------------- |
| `↑`      | Previous command        |
| `↓`      | Next command            |

## During Agent Response

| Shortcut | Action                            |
| -------- | --------------------------------- |
| `Ctrl+C` | Cancel/interrupt current response |

## Modes & Toggles

| Shortcut    | Action                                    |
| ----------- | ----------------------------------------- |
| `Tab`       | Toggle thinking mode (extended reasoning) |
| `Shift+Tab` | Toggle auto-accept edit mode              |
| `Ctrl+P`    | Toggle plan mode                          |
| `Ctrl+R`    | Expand/collapse thinking content          |
| `?`         | Toggle shortcuts display in footer        |


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

### Plan Mode (`Ctrl+P`)

When enabled, AdaL helps you design and plan features without modifying code or config files:

```
[Plan Mode: ON]

> Plan how to implement rate limiting for our API

✓ Reading API structure...
✓ Researching best practices...
✓ Creating docs/plan_rate_limiting.md

Created comprehensive plan with:
- Current implementation analysis
- Recommended approach (token bucket algorithm)
- Files to modify (middleware.js, config.js)
- Step-by-step implementation
- Testing strategy
```

**Capabilities in Plan Mode:**
- ✅ Read any file (explore codebase)
- ✅ Web search and research
- ✅ Create/edit planning docs (`.md`, `.txt`, `.rst`, etc.)
- ❌ Modify code/config files (`.py`, `.js`, `.json`, `.yaml`, etc.)

**When to use:**
- Planning complex features before implementation
- Researching design patterns and best practices
- Creating technical specs and architecture docs
- Analyzing codebases without making changes

**Workflow:** `Ctrl+P` → design → review plan → `Ctrl+P` again → implement

**Related:** [Slash Commands](./slash-commands.md) · [Workflows & Examples](../01-getting-started/workflows-and-examples.md)

