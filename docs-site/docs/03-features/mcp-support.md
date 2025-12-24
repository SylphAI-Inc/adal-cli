---
sidebar_position: 3
title: MCP Support
---


# MCP Quick Reference Guide

A quick guide to adding and using MCP servers in AdaL CLI to extend AdaL's capabilities with external tools.

---

## How It Works

When you add an MCP server:

1. **Configuration is saved** to `~/.adal/settings.json` (per-project: one config per working directory)
2. **Nothing downloads yet** - servers use `npx` to run on-demand
3. **Connection happens** when AdaL starts up (or when you authenticate OAuth servers)
4. **Servers stay connected** throughout your AdaL session - no reconnecting per-query

**Important**: MCP servers are **long-lived processes**. They connect once when AdaL starts, then stay alive until you close AdaL or disable the server.

**Per-project configuration**: Each working directory gets its own MCP server settings. Servers configured in `/home/user/project-a` won't appear when you run AdaL from `/home/user/project-b`.

---

## Quick Start (3 steps)

```bash
# 1. Start AdaL CLI
adal

# 2. Add a server (choose method based on your needs)
# Managed server (use shortcut name)
> /mcp add linear

# Package-based server (use --command and --args)
> /mcp add chrome-devtools --command npx --args "-y,chrome-devtools-mcp@latest"

# Remote server (use --transport and --url)
> /mcp add custom-api --transport sse --url https://api.example.com/sse

# 3. Authenticate (if needed)
> /mcp
# Navigate to server → Enter → Authenticate
```

**How to verify**: After authentication, AdaL displays the tool count (e.g., "15 tools available"). This confirms the server is connected and working.

Done! Now AdaL can use the server's tools.

---

## Using MCP Tools

Once servers are added and authenticated, just talk to AdaL naturally:

**Linear Example**:
```
You: Create a Linear issue titled "Fix login bug" in the Backend project with high priority

AdaL: I'll create that Linear issue for you.
[Uses linear_create_issue tool]
✓ Created issue BACK-123: Fix login bug
   Priority: High
   URL: https://linear.app/company/issue/BACK-123
```

**GitHub Example**:
```
You: Show me my recent GitHub pull requests

AdaL: Let me fetch your recent pull requests.
[Uses github_list_prs tool]
Found 3 open pull requests:
1. feat: MCP integration (#276) - opened 2 days ago
2. fix: Auth timeout (#275) - opened 5 days ago
3. docs: Update README (#274) - opened 1 week ago
```

**Postgres Example**:
```
You: Query the users table and show the count by status

AdaL: I'll query the users table for you.
[Uses postgres_query tool]
Results:
- active: 1,234 users
- inactive: 456 users
- pending: 89 users
```

---

## Adding Servers

### Popular Services (Pre-configured)

**OAuth Services** (browser authentication):
```bash
/mcp add linear      # Project management
/mcp add notion      # Note-taking and wikis
/mcp add sentry      # Error tracking
```

**API Key Services** (set environment variable first):
```bash
# Set your token
export GITHUB_TOKEN="ghp_xxxxxxxxxxxx"

# Add server
/mcp add github      # Repositories and issues
/mcp add gitlab      # GitLab projects
/mcp add slack       # Slack workspace
```

**No Authentication**:
```bash
/mcp add filesystem  # Local file access
/mcp add playwright  # Browser automation
```

**Database**:
```bash
# Option 1: Provide connection string directly
/mcp add postgres postgresql://user:pass@localhost:5432/dbname

# Option 2: Use environment variable
export POSTGRES_URL="postgresql://user:pass@localhost:5432/dbname"
/mcp add postgres
```

**Connection string format**: `postgresql://[user[:password]@][host][:port][/dbname][?param1=value1&...]`

Examples:
- Local database: `postgresql://localhost:5432/mydb`
- With authentication: `postgresql://admin:secret@db.example.com:5432/production`
- SSL connection: `postgresql://user:pass@host:5432/db?sslmode=require`

**How to verify**: After adding, use the "Test Connection" action in `/mcp` dialog to confirm database connectivity.

---

## MCP Pre Set Server List Reference

| Server           | Category        | Authentication              | What it does                          |
| ---------------- | --------------- | --------------------------- | ------------------------------------- |
| **linear**       | Project Mgmt    | OAuth (browser)             | Create/manage issues, projects, teams |
| **notion**       | Docs & Wiki     | OAuth (browser)             | Search, read, edit Notion pages       |
| **sentry**       | Error Tracking  | OAuth (browser)             | View and manage error reports         |
| **github**       | Code Hosting    | API key (`GITHUB_TOKEN`)    | Manage repos, issues, PRs             |
| **gitlab**       | Code Hosting    | API key (`GITLAB_TOKEN`)    | Manage GitLab projects                |
| **postgres**     | Database        | Connection string           | Query and manage PostgreSQL           |
| **filesystem**   | Local Files     | None                        | Read/write local files                |
| **playwright**   | Browser Testing | None                        | Automate web browsers                 |
| **brave-search** | Web Search      | API key (`BRAVE_API_KEY`)   | Search the web                        |
| **slack**        | Communication   | API key (`SLACK_BOT_TOKEN`) | Send messages, read channels          |


---

## Authentication Guides

### OAuth Services (Linear, Notion, Sentry)

**How it works**:
1. Add server → AdaL saves config but doesn't connect yet
2. Authenticate → Browser opens, you approve, **tokens cached locally**
3. AdaL immediately connects the server (no restart needed)

**Token storage**: OAuth tokens are cached in `~/.adal/mcp-auth/`. If you delete this folder, you'll need to re-authenticate.

**Setup steps**:
```bash
# 1. Add server
/mcp add linear

# 2. Open MCP dialog
/mcp

# 3. Navigate to server and press Enter
# Use arrow keys → select "linear" → Enter

# 4. Choose "Authenticate"
# Browser opens → Log in → Approve → Done!

# ✓ You'll see "15 tools available"
```

**Important**: OAuth servers connect **immediately after authentication**. No restart needed.

### API Key Services (GitHub, GitLab, Slack)

**How it works**:
1. AdaL reads environment variables (`GITHUB_TOKEN`, etc.) **when it starts**
2. If you add a token **after** AdaL is already running, it won't see it
3. **Restart AdaL** to pick up new environment variables

**Setup steps**:
```bash
# 1. Get your API key
# GitHub: https://github.com/settings/tokens
# GitLab: https://gitlab.com/-/profile/personal_access_tokens
# Slack: https://api.slack.com/apps

# 2. Set your token (AdaL must be closed)
export GITHUB_TOKEN="your_token_here"

# 3. Verify the token is set (should display your token)
echo $GITHUB_TOKEN

# 4. Add server
/mcp add github
# ✓ Success: Server will test connection and show "X tools available"

# 5. Restart AdaL (if it was already running)
# Exit current session (Ctrl+C)
adal
```

**How to verify**: After adding the server, AdaL will display "X tools available" (e.g., "26 tools available" for GitHub). This confirms your token is valid and the server is working.

**Make it permanent** (survives terminal restarts):
```bash
# Add to shell config (run once)
echo 'export GITHUB_TOKEN="your_token_here"' >> ~/.zshrc
source ~/.zshrc
```

**Token storage**: API keys are stored in your **environment**, not by AdaL. AdaL reads them from env vars each time it starts.

---

## Custom Servers

### Package-Based Servers (stdio transport)

Run MCP servers from package managers using `--command` and `--args`:

**NPM packages via npx**:
```bash
# Chrome DevTools MCP server
/mcp add chrome-devtools --command npx --args "-y,chrome-devtools-mcp@latest"

# Airtable MCP server (with API key)
/mcp add airtable --command npx --args "-y,airtable-mcp-server" --env "AIRTABLE_API_KEY=your_key"

# Custom organization package
/mcp add my-tool --command npx --args "-y,@myorg/mcp-server@1.2.3"
```

**Python packages**:
```bash
# Using uvx (recommended for Python MCP servers)
/mcp add python-tool --command uvx --args "python-mcp-server"

# Using python directly
/mcp add custom-python --command python --args "-m,mcp_server"

# With environment variables
/mcp add python-api --command uvx --args "api-server" --env "API_KEY=secret"
```

**Node.js scripts**:
```bash
# Direct Node.js execution
/mcp add node-server --command node --args "/path/to/server.js"

# With Node.js flags
/mcp add node-app --command node --args "--experimental-modules,/path/to/server.mjs"
```

**Arguments format**: Comma-separated values in `--args` (e.g., `"-y,package@version,--flag,value"`)

### Remote Servers (sse/http transports)

Connect to remotely hosted MCP servers:

**SSE (Server-Sent Events)**:
```bash
# Basic SSE server
/mcp add my-server --transport sse --url https://api.example.com/sse

# With API key authentication
/mcp add private-api --transport sse --url https://api.company.com/sse \
  --header "X-API-Key:your-key-here"

# With multiple headers
/mcp add secure-sse --transport sse --url https://api.example.com/sse \
  --header "Authorization:Bearer token" \
  --header "X-Custom-Header:value"
```

**Why `/sse` suffix?**: MCP servers use Server-Sent Events (SSE) for communication. The `/sse` endpoint is the standard MCP protocol path. If you're unsure, check the server's documentation for the correct URL.

**HTTP (REST endpoints)**:
```bash
# Basic HTTP server
/mcp add http-api --transport http --url https://api.example.com/mcp

# With Bearer token authentication
/mcp add secure-api --transport http --url https://api.example.com/mcp \
  --header "Authorization:Bearer your-token"

# With environment variables
/mcp add env-api --transport http --url https://api.example.com/mcp \
  --header "X-API-Key:${API_KEY}" \
  --env "API_KEY=your_secret"
```

### Multiple Instances (Different Environments)

You can add the same server type multiple times for different environments or tenants:

```bash
# Different URLs (staging vs production)
/mcp add linear-prod --transport sse --url https://mcp.linear.app/sse
/mcp add linear-staging --transport sse --url https://mcp-staging.linear.app/sse

# Same MCP server, different tenant/workspace (using --resource)
/mcp add jira-team-a \
  --transport sse \
  --url https://mcp.atlassian.com/sse \
  --resource https://team-a.atlassian.net

/mcp add jira-team-b \
  --transport sse \
  --url https://mcp.atlassian.com/sse \
  --resource https://team-b.atlassian.net
```

Each instance maintains its own authentication and connection.

**Note on `--resource` flag**: In the current AdaL CLI + mainstream MCP server usage, `--resource` is no longer a necessary concept, but rather an optional, legacy/enterprise-level parameter. Most popular MCP servers (Linear, GitHub, Notion, etc.) don't require resource specification - they handle multi-tenant scenarios through authentication and configuration. The `--resource` flag is primarily used for enterprise servers that need explicit tenant/workspace identification.

### Advanced: Custom Server Flags

| Flag           | Usage                          | Example                                           |
| -------------- | ------------------------------ | ------------------------------------------------- |
| `--command`    | Executable to run (stdio)      | `--command npx`                                   |
| `--args`       | Command arguments (stdio)      | `--args "-y,chrome-devtools-mcp@latest"`          |
| `--transport`  | Transport type                 | `--transport sse` or `--transport http`           |
| `--url`        | Server URL (sse/http)          | `--url https://api.example.com/sse`               |
| `--header`     | Authentication header          | `--header "Authorization:Bearer token"`           |
| `--env`        | Environment variables          | `--env "KEY=value,KEY2=value2"`                   |
| `--resource`   | Resource URL (multi-instance)  | `--resource https://tenant.atlassian.net`         |
| `--timeout`    | Connection timeout             | `--timeout 60000` (milliseconds)                  |

**Note on `--resource`**: This is an optional, legacy/enterprise-level parameter. In current AdaL CLI + mainstream MCP server usage, `--resource` is not necessary for most servers (Linear, GitHub, Notion, etc.). Only use it if the server's documentation explicitly requires it for multi-tenant setups.

**Transport Types**:
- **stdio**: Local process communication (package-based servers)
- **sse**: Server-Sent Events (remote HTTP streaming)
- **http**: HTTP requests (remote REST endpoints)

---

## Managing Servers

### View All Servers

```bash
/mcp
```

**Server Status meanings**:
- **Enabled + Authenticated**: Server is connected, tools available ✓
- **Enabled + Not Authenticated**: Server will connect when you authenticate (OAuth servers)
- **Disabled**: Server config saved but not connected (enable to reconnect)
- **Needs Setup**: Missing API key or other configuration

**Why disable instead of remove?**: Keep the configuration but temporarily turn it off (useful for servers with quota limits or during debugging).

### Server Actions

Navigate to a server → press Enter:

- **Enable/Disable** - Turn server on/off without removing
- **Authenticate** - Start OAuth flow (OAuth servers)
- **Test Connection** - Check if server is working
- **Remove Server** - Delete server configuration
- **Remove Authentication** - Clear OAuth tokens



## Understanding Server Lifecycle

### Adding a Server

**What happens**:
```bash
/mcp add linear
```
1. AdaL **saves configuration** to `~/.adal/settings.json` (project-specific)
2. AdaL **tests the connection** (for non-OAuth servers) - takes 2-5 seconds
3. **Server is not connected yet** - actual connection happens on AdaL startup (or immediately after OAuth authentication)

**For OAuth servers**: Connection test is **skipped** (OAuth needs browser flow first). You'll see a message to authenticate via `/mcp` dialog.

**First-time server**: The first time you add any MCP server, `npx` downloads the package (~10-30 seconds). Subsequent additions are faster.

### Authenticating (OAuth only)

**What happens**:
1. AdaL spawns the MCP server process
2. Server opens your browser with OAuth URL
3. You approve → tokens cached locally → **server connects immediately**
4. AdaL discovers available tools (shows "15 tools available")

**No restart needed** - OAuth servers connect right after authentication.

### When Servers Connect

**AdaL startup**: All enabled servers with valid credentials connect automatically when you start AdaL.

**During session**: Servers stay connected (persistent). No reconnecting per-query.

**After authentication**: OAuth servers connect immediately after successful authentication.

### Enable/Disable

**Disable**: Server is **disconnected immediately** and won't appear in tool list. Configuration remains saved in settings.json.

**Enable**: Server **connects immediately if AdaL is already running and credentials are valid**

### Test Connection

**What it tests**:
- Can AdaL reach the server? (network connectivity)
- Are credentials valid? (API keys, OAuth tokens)
- How many tools are available? (confirms server is working)

**Use it when**: Debugging connection issues or verifying a server is still working after changes.

### Remove Server

**What happens**:
1. Server is **disconnected immediately**
2. Configuration is **deleted** from `~/.adal/settings.json`
3. **OAuth tokens remain** in `~/.adal/mcp-auth/` (use "Remove Authentication" to clear them)
