---
sidebar_position: 3
title: MCP
---

# Connect AdaL CLI to Tools via MCP

Connect AdaL to Linear, GitHub, Notion, databases, and more using MCP (Model Context Protocol).

## Quick Start (2 minutes)

```bash
# 1. Start AdaL
adal

# 2. Add a server (using shortcut)
/mcp add linear

# 3. Authenticate (browser opens)
/mcp → select server → Authenticate
```

Done! Ask AdaL: *"Create a Linear issue for the login bug"*

---

## Two Ways to Add Servers

| Method | Syntax | When to Use |
|--------|--------|-------------|
| **Shortcut** | `/mcp add <name>` | Pre-configured servers managed by AdaL CLI team |
| **Custom** | `/mcp add <name> --command ...` | Any MCP server (npm package, Python, remote) |

### Add Shortcut Servers

Pre-configured by the AdaL CLI team. Just use the name - no flags needed.

| Shortcut | Auth Type | Command |
|----------|-----------|---------|
| `linear` | OAuth | `/mcp add linear` |
| `notion` | OAuth | `/mcp add notion` |
| `sentry` | OAuth | `/mcp add sentry` |
| `github` | API Key | `/mcp add github` |
| `gitlab` | API Key | `/mcp add gitlab` |
| `slack` | API Key | `/mcp add slack` |
| `postgres` | Conn String | `/mcp add postgres <connection_string>` |
| `filesystem` | None | `/mcp add filesystem` |
| `playwright` | None | `/mcp add playwright` |
| `brave-search` | API Key | `/mcp add brave-search` |

#### Setting Up Shortcuts

**OAuth Servers** (linear, notion, sentry):
```bash
/mcp add linear
/mcp                    # Open dialog
# → Select server → Authenticate
# Browser opens → Approve → Done!
```

**API Key Servers** (github, gitlab, slack):
```bash
# Set token BEFORE starting AdaL
export GITHUB_TOKEN="ghp_xxxx" # macOS / Linux 
# OR
$env:GITHUB_TOKEN="ghp_xxxx" # Windows

adal
/mcp add github
```

**Database** (postgres):
```bash
/mcp add postgres postgresql://user:pass@localhost:5432/mydb
```

### Add Custom Servers

For any MCP package not in the shortcut list. Use `--command` and `--args` flags.

#### NPM Packages

```bash
/mcp add chrome-devtools --command npx --args "-y,chrome-devtools-mcp@latest"
/mcp add airtable --command npx --args "-y,airtable-mcp-server" --env "AIRTABLE_API_KEY=xxx"
```

#### Python Packages

```bash
/mcp add py-tool --command uvx --args "python-mcp-server"
```

#### Remote Servers (SSE/HTTP)

```bash
/mcp add my-api --transport sse --url https://api.example.com/sse
```

#### Flags Reference

| Flag | Purpose | Example |
|------|---------|---------|
| `--command` | Executable | `--command npx` |
| `--args` | Arguments | `--args "-y,pkg@latest"` |
| `--transport` | sse/http | `--transport sse` |
| `--url` | Server URL | `--url https://...` |
| `--header` | Auth header | `--header "Authorization:Bearer xxx"` |
| `--env` | Env vars | `--env "KEY=value"` |
---

## Managing Servers

```bash
/mcp                    # Open server list
```

**Actions** (select server → Enter):
- **Enable/Disable** - Saves tokens by loading only servers you need. Takes effect instantly mid-session.
- **Test Connection** - Verify server is working
- **Remove** - Delete server configuration


---

## Authenticate Servers

### OAuth Servers (linear, notion, sentry)

**How it works**:
1. Add server → Config saved, not connected yet
2. Authenticate → Browser opens, you approve
3. Tokens cached locally → Server connects immediately

```bash
/mcp add linear         # Add server
/mcp                    # Open dialog
# → Select server → Authenticate
# Browser opens → Approve → Done!
# ✓ "15 tools available"
```

**Token storage**: `~/.adal/mcp-auth/`. Delete folder to re-authenticate.

### API Key Servers (github, gitlab, slack)

**How it works**:
1. AdaL reads env vars (`GITHUB_TOKEN`, etc.) **at startup**
2. If you add token after AdaL starts → **restart required**

```bash
# Set token (AdaL must be closed)
export GITHUB_TOKEN="ghp_xxxx"

# Verify
echo $GITHUB_TOKEN

# Start and add
adal
/mcp add github
# ✓ "26 tools available"
```

| Server | Environment Variable | Get Token |
|--------|---------------------|-----------|
| github | `GITHUB_TOKEN` | [github.com/settings/tokens](https://github.com/settings/tokens) |
| gitlab | `GITLAB_TOKEN` | [gitlab.com/-/profile/personal_access_tokens](https://gitlab.com/-/profile/personal_access_tokens) |
| slack | `SLACK_BOT_TOKEN` | [api.slack.com/apps](https://api.slack.com/apps) |
| brave-search | `BRAVE_API_KEY` | [brave.com/search/api](https://brave.com/search/api) |

:::tip Make Token Permanent
```bash
echo 'export GITHUB_TOKEN="xxx"' >> ~/.zshrc
source ~/.zshrc
```
:::

## Examples

**Linear**:
> "Create a high-priority issue titled 'Fix auth timeout' in Backend"

**GitHub**:
> "Show my open pull requests"

**Postgres**:
> "Count users by status in the users table"
