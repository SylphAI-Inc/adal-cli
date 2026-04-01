---
sidebar_position: 3
title: MCP Servers
description: "Connect AdaL to Linear, GitHub, Notion, Slack, PostgreSQL, Playwright, and more using MCP (Model Context Protocol). Add servers in seconds with built-in shortcuts or custom configurations."
---

# Connect AdaL to Tools via MCP (Model Context Protocol)

Connect AdaL to Linear, GitHub, Notion, Canva, databases, and more using [MCP (Model Context Protocol)](https://modelcontextprotocol.io/) — the open standard for connecting AI agents to external tools and data sources.

## Quick Start (2 minutes)

```bash
# 1. Start AdaL
adal

# 2. Add a server (shortcut)
/mcp add linear
# Browser auth opens automatically when required
```

For OAuth-capable servers, auth opens automatically during add. Example:

```bash
/mcp add canva --transport http --url https://mcp.canva.com/mcp
✦ Adding custom server: canva
⎿ Server added: canva
  (opening browser for authentication...)
```

Done! Ask AdaL: *"Create a Linear issue for the login bug"*.

## Two Ways to Add Servers

| Method | Syntax | When to Use |
| --- | --- | --- |
| **Shortcut** | `/mcp add <name>` | Pre-configured servers managed by AdaL CLI team |
| **Custom** | `/mcp add <name> ...` | Any MCP server (npm package, Python, remote HTTP/SSE) |

### Add Shortcut Servers

Pre-configured by the AdaL CLI team. Just use the name - no flags needed.

| Shortcut | Auth Type | Command |
| --- | --- | --- |
| `linear` | OAuth | `/mcp add linear` |
| `notion` | OAuth | `/mcp add notion` |
| `sentry` | OAuth | `/mcp add sentry` |
| `github` | API Key | `/mcp add github` |
| `gitlab` | API Key | `/mcp add gitlab` |
| `slack` | API Key | `/mcp add slack` |
| `postgres` | Conn String | `/mcp add postgres <connection_string>` |
| `filesystem` | None | `/mcp add filesystem` |
| `playwright` | None | `/mcp add playwright` |
| `chrome-devtools` | None | `/mcp add chrome-devtools` |
| `brave-search` | API Key | `/mcp add brave-search` |

#### Setting Up Shortcuts

**OAuth Servers** (linear, notion, sentry):

```bash
/mcp add linear
# In many cases, browser auth may open automatically after add
# If not:
/mcp
# → Select server → Authenticate
# Browser opens → Approve → Done!
```

**API Key Servers** (github, gitlab, slack):

```bash
# Set token BEFORE starting AdaL
export GITHUB_TOKEN="ghp_xxxx"      # macOS / Linux
# OR
$env:GITHUB_TOKEN="ghp_xxxx"        # Windows PowerShell

adal
/mcp add github
```

**Database** (postgres):

```bash
/mcp add postgres postgresql://user:pass@localhost:5432/mydb
```

### Add Custom Servers

For any MCP package not in the shortcut list.

#### Option 1: Add a remote HTTP server (recommended)

```bash
# Basic syntax
/mcp add <name> --transport http --url <https://...>

# Real example
/mcp add canva --transport http --url https://mcp.canva.com/mcp

# Example with header
/mcp add secure-api --transport http --url https://api.example.com/mcp --header "Authorization:Bearer ${API_TOKEN}"
```

#### Option 2: Add a remote SSE server (legacy/deprecated where HTTP exists)

```bash
# Basic syntax
/mcp add <name> --transport sse --url <https://...>

# Example
/mcp add asana --transport sse --url https://api.example.com/sse
```

#### Option 3: Add a local stdio server (npm/python/local scripts)

```bash
# NPM package
/mcp add airtable --command npx --args "-y,airtable-mcp-server" --env "AIRTABLE_API_KEY=xxx"

# Python package
/mcp add py-tool --command uvx --args "python-mcp-server"
```

#### Important: option ordering

Place MCP flags before values they configure, and keep command payload values quoted when needed:

- `--transport` + `--url` for remote servers
- `--command` + `--args` for stdio servers
- use `--env` / `--header` for credentials and auth headers

#### Flags Reference

| Flag | Purpose | Example |
| --- | --- | --- |
| `--command` | Executable for stdio server | `--command npx` |
| `--args` | Arguments passed to command | `--args "-y,pkg@latest"` |
| `--transport` | Remote transport (`http` or `sse`) | `--transport http` |
| `--url` | Remote server URL | `--url https://...` |
| `--header` | HTTP auth/custom header | `--header "Authorization:Bearer ${TOKEN}"` |
| `--env` | Environment variables | `--env "KEY=value"` |

## Managing Servers

```bash
/mcp
# Open server list
```

**Actions** (select server → Enter):

- **Enable/Disable** - Load only servers you need.
- **Authenticate** - Start/continue auth flow.
- **Test Connection** - Verify server is working.
- **Remove** - Delete server configuration.

### Server Card Status (Source of Truth)

After add/auth, use server card status to confirm readiness:

- **Connected** - Ready to use
- **Needs Auth** - Authenticate required
- **Error** - Connection/config/credential issue
- **Disabled** - Not currently active

## Authenticate Servers

### OAuth Servers (linear, notion, sentry, and compatible remote OAuth servers)

**How it works now**:

1. Add server
2. Config is saved
3. AdaL may immediately open browser auth during add
4. If browser does not auto-open, authenticate from `/mcp` dialog
5. After approval, server becomes usable (tools discovered/available)

```bash
/mcp add linear
# may auto-open browser
# fallback:
/mcp
# → Select server → Authenticate
```

**Token storage**: `~/.adal/mcp-auth/`. Delete folder to re-authenticate.

### API Key Servers (github, gitlab, slack)

**How it works**:

1. AdaL reads env vars (`GITHUB_TOKEN`, etc.) at startup
2. If token is added after AdaL starts, restart AdaL and re-open session flow

```bash
# Set token (AdaL must be closed)
export GITHUB_TOKEN="ghp_xxxx"

# Verify
echo $GITHUB_TOKEN

# Start and add
adal
/mcp add github
```

| Server | Environment Variable | Get Token |
| --- | --- | --- |
| github | `GITHUB_TOKEN` | [github.com/settings/tokens](https://github.com/settings/tokens) |
| gitlab | `GITLAB_TOKEN` | [gitlab.com/-/profile/personal_access_tokens](https://gitlab.com/-/profile/personal_access_tokens) |
| slack | `SLACK_BOT_TOKEN` | [api.slack.com/apps](https://api.slack.com/apps) |
| brave-search | `BRAVE_API_KEY` | [brave.com/search/api](https://brave.com/search/api) |

Make token permanent:

```bash
echo 'export GITHUB_TOKEN="xxx"' >> ~/.zshrc
source ~/.zshrc
```

## Examples

**Linear**:

> "Create a high-priority issue titled 'Fix auth timeout' in Backend"

**GitHub**:

> "Show my open pull requests"

**Postgres**:

> "Count users by status in the users table"

**Canva**:

> "Create a social post design draft for product launch"

## Why MCP with AdaL?

MCP (Model Context Protocol) is the emerging open standard for connecting AI agents to external tools. AdaL's MCP support means you can:

- **Use the same MCP servers** you'd use with Claude Desktop, Cursor, or other MCP-compatible clients
- **Manage servers from the CLI** — no config files to edit manually
- **OAuth built-in** — one-step add flow with automatic auth where supported
- **Enable/disable on the fly** — load only what you need

**Related:** [Skills & Plugins](./plugins-and-skills.md) · [Slash Commands](./slash-commands.md) · [Keyboard Shortcuts](./keyboard-shortcuts.md)
