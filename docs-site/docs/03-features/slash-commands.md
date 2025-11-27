---
sidebar_position: 0
title: Slash Commands
---

# Slash Commands

All commands start with `/`. Type `/` and press `Tab` for autocomplete.

## Quick Reference

| Command | Alias | Description |
|---------|-------|-------------|
| `/help` | `/?` | Show help information |
| `/model [name]` | - | Switch AI model |
| `/clear` | - | Clear conversation history |
| `/resume` | `/sessions` | Resume previous session |
| `/init [msg]` | - | Generate AGENTS.md file |
| `/compact` | - | Compress conversation memory |
| `/stats` | `/usage` | Show session statistics |
| `/health` | - | Check system health |
| `/mcp` | - | Manage MCP servers |
| `/bashes` | - | List background processes |
| `/auth` | - | Show auth status |
| `/logout` | - | Sign out and exit |
| `/quit` | `/exit` | Exit AdaL CLI |
| `/theme` | - | Change theme |
| `/about` | - | Show version info |
| `/bug [desc]` | - | Report a bug |

---

## Session Commands

### `/clear`
Clears conversation history (frontend + backend).

```
/clear
```
**Shortcut:** `Ctrl+L` (display only)

### `/resume`
Opens dialog to load a previous session.

```
/resume
```

### `/quit`
Exit AdaL CLI gracefully.

**Shortcut:** `Ctrl+C`

```
/quit
/exit
```

---

## Model Commands

### `/model`
Switch AI models or open selection dialog.

```
/model                  # Open dialog
/model claude-3.5-sonnet
/model gpt-4o
/model ollama/qwen3-coder:30b
```

**Available models:**
- **Claude:** `claude-3.5-sonnet`, `claude-3.7-sonnet`, `claude-3-opus`, `claude-3-haiku`
- **OpenAI:** `gpt-4o`, `gpt-4-turbo`, `o3-mini`
- **Local:** `ollama/qwen3-coder:30b`, `ollama/gpt-oss:20b`

---

## Memory Commands

### `/compact`
Compresses conversation into a summary to save tokens.

```
/compact
```
Press `ESC` to cancel. Shows compression stats when done.

### `/init`
Generates `AGENTS.md` with project-specific guidelines.

```
/init                       # Default
/init focus on testing      # Custom focus
```

---

## System Commands

### `/health`
Check CLI and backend status.

```
/health
```

### `/bashes`
List running background processes.

```
/bashes
```

### `/stats`
Show session statistics (duration, tokens, tool usage).

```
/stats
/usage
```

---

## MCP Commands

### `/mcp`
Manage MCP server integrations.

```
/mcp                  # Open dialog
/mcp add <server>     # Add server
/mcp reload           # Reload configs
```

**Integrations:** Linear, GitHub, Notion, Slack, PostgreSQL, custom servers.

---

## Auth Commands

### `/auth`
Show authentication status and token info.

```
/auth
```

### `/logout`
Sign out and clear credentials.

```
/logout
```

---

## Other Commands

### `/theme`
Change CLI theme.

```
/theme
```

### `/about`
Show version and system info.

```
/about
```

### `/bug`
Report a bug with auto-generated GitHub issue.

```
/bug CLI crashes when switching models
```

### `/help`
Show available commands.

```
/help
/?
```

---

## Tips

- Use `/help` when unsure about commands
- Use `/compact` when conversations get long
- Run `/init` at project start
- Check `/health` if having connection issues

**Related:** [MCP Support](./mcp-support.md) · [Troubleshooting](../07-troubleshooting/common-issues.md)
