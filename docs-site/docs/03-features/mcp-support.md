---
sidebar_position: 3
title: MCP Support
---


# MCP Quick Reference Guide

A quick guide to adding and using MCP servers in AdaL CLI to extend AdaL's capabilities with external tools.

---

## What is MCP?

MCP (Model Context Protocol) connects AdaL to external services like Linear, GitHub, Notion, and more. Once connected, AdaL can use these services' tools directly in your conversations.

**Example**: After adding Linear, you can say *"Create a Linear issue for this bug"* and AdaL will create it for you.

---

## Quick Start (3 steps)

```bash
# 1. Start AdaL CLI
AdaL

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

Done! Now AdaL can use the server's tools.

---

## Adding Servers

AdaL supports three ways to add MCP servers:

### Method 1: Managed Servers (Shortcut Names)

**What are managed servers?** Pre-configured popular services that you can add using just their name - AdaL handles the transport setup automatically.

**OAuth-based** (browser authentication):
```bash
/mcp add linear      # Project management
/mcp add notion      # Note-taking and wikis
/mcp add sentry      # Error tracking
```

**API Key-based** (set environment variable first):
```bash
# Set your token
export GITHUB_TOKEN="ghp_xxxxxxxxxxxx"

# Add server
/mcp add github      # Repositories and issues
/mcp add gitlab      # GitLab projects
/mcp add slack       # Slack workspace
```

**No authentication required**:
```bash
/mcp add filesystem  # Local file access
/mcp add playwright  # Browser automation
```

**Database** (connection string or environment variable):
```bash
# Option 1: Provide connection string directly
/mcp add postgres postgresql://user:pass@localhost:5432/dbname

# Option 2: Use environment variable
export POSTGRES_URL="postgresql://user:pass@localhost:5432/dbname"
/mcp add postgres
```

**Available managed servers**: linear, notion, sentry, github, gitlab, slack, filesystem, playwright, postgres, brave-search

---

### Method 2: Standard Adds

For custom servers or packages not included in managed shortcuts, use standard add commands with explicit transport configuration.

#### Package-Based Servers (stdio transport)

Run MCP servers from package managers using `--command` and `--args`:

**NPM packages via npx**:
```bash
# Chrome DevTools MCP server
/mcp add chrome-devtools --command npx --args "-y,chrome-devtools-mcp@latest"

# Airtable MCP server (with API key)
/mcp add airtable --command npx --args "-y,airtable-mcp-server" --env "AIRTABLE_API_KEY=your_key"

# Custom organization package
/mcp add my-tool --command npx --args "-y,@myorg/mcp-server@1.2.3"

# With additional flags
/mcp add advanced-tool --command npx --args "-y,tool-package,--verbose,--config=/path/to/config"
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

#### Remote Servers (sse/http transports)

Connect to remotely hosted MCP servers:

**SSE (Server-Sent Events)**:
```bash
# Basic SSE server
/mcp add asana --transport sse --url https://mcp.asana.com/sse

# With API key authentication
/mcp add private-api --transport sse --url https://api.company.com/sse \
  --header "X-API-Key:your-key-here"

# With multiple headers
/mcp add secure-sse --transport sse --url https://api.example.com/sse \
  --header "Authorization:Bearer token" \
  --header "X-Custom-Header:value"
```

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

#### Multi-Instance Servers

Add the same server multiple times for different environments or tenants:

```bash
# Production environment
/mcp add company-prod --transport sse --url https://mcp.company.com/sse \
  --resource https://prod.company.com

# Staging environment
/mcp add company-staging --transport sse --url https://mcp.company.com/sse \
  --resource https://staging.company.com

# Different teams/tenants
/mcp add linear-team-a --transport sse --url https://mcp.linear.app/sse \
  --resource https://linear.app/team-a

/mcp add linear-team-b --transport sse --url https://mcp.linear.app/sse \
  --resource https://linear.app/team-b
```
---

## Server List Reference

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

### API Key Services (GitHub, GitLab, Slack)

```bash
# 1. Get your API key
# GitHub: https://github.com/settings/tokens
# GitLab: https://gitlab.com/-/profile/personal_access_tokens
# Slack: https://api.slack.com/apps

# 2. Set environment variable
export GITHUB_TOKEN="your_token_here"

# 3. Add server
/mcp add github

# 4. Restart AdaL if it was already running
# ✓ Tools available immediately
```

**Make it permanent** (add to `~/.zshrc` or `~/.bashrc`):
```bash
echo 'export GITHUB_TOKEN="your_token_here"' >> ~/.zshrc
source ~/.zshrc
```

---

---

## Command Reference

### Available Flags

| Flag           | Usage                          | Example                                           |
| -------------- | ------------------------------ | ------------------------------------------------- |
| `--command`    | Executable to run (stdio)      | `--command npx`                                   |
| `--args`       | Command arguments (stdio)      | `--args "-y,chrome-devtools-mcp@latest"`          |
| `--transport`  | Transport type                 | `--transport sse` or `--transport http`           |
| `--url`        | Server URL (sse/http)          | `--url https://api.example.com/sse`               |
| `--header`     | Authentication header          | `--header "Authorization:Bearer token"`           |
| `--env`        | Environment variables          | `--env "KEY=value,KEY2=value2"`                   |
| `--resource`   | Resource URL (multi-instance)  | `--resource https://tenant.atlassian.net`         |
| `--timeout`    | Connection timeout             | `--timeout 60000`                                 |

### Transport Types

- **stdio**: Local process communication (package-based servers)
- **sse**: Server-Sent Events (remote HTTP streaming)
- **http**: HTTP requests (remote REST endpoints)

---

## Managing Servers

### View All Servers

```bash
/mcp
```

Shows:
- Server names
- Status (authenticated, tools count)
- Type (OAuth, API key, etc.)

### Server Actions

Navigate to a server → press Enter:

- **Enable/Disable** - Turn server on/off without removing
- **Authenticate** - Start OAuth flow (OAuth servers)
- **Test Connection** - Check if server is working
- **Remove Server** - Delete server configuration
- **Remove Authentication** - Clear OAuth tokens

### Test Connection

```bash
/mcp → Navigate to server → Enter → Test Connection

# Shows:
# ✓ Healthy! Response time: 523ms, 15 tools available
```

### Remove Server

```bash
/mcp → Navigate to server → Enter → Remove Server
# Confirm: y

# ✓ Server removed successfully
```

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
