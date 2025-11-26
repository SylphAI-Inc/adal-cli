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

# 2. Add a server
# from pre-configured list
> /mcp add linear 


#add any server 
> /mcp add sever --transport sse url 

# 3. Authenticate (if needed)
> /mcp
# Navigate to "linear" → Enter → Authenticate


```

Done! Now AdaL can use Linear tools.

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
# Option 1: Provide connection string
/mcp add postgres postgresql://user:pass@localhost:5432/dbname

# Option 2: Use environment variable
export POSTGRES_URL="postgresql://user:pass@localhost:5432/dbname"
/mcp add postgres
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
| **google-drive** | Cloud Storage   | OAuth (CLI setup)           | Access Google Drive files             |

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

### Google Drive (CLI OAuth)

```bash
# 1. Run authentication command first
npx -y @modelcontextprotocol/server-gdrive auth
# Follow the prompts in terminal

# 2. Add to AdaL
/mcp add google-drive

# ✓ Ready to use
```

---

## Custom Servers

### Basic Custom Server

```bash
/mcp add my-server --url https://api.example.com/sse
```

### With Authentication Header

```bash
/mcp add my-server \
  --url https://api.example.com/sse \
  --header "Authorization:Bearer ${API_KEY}" \
  --env "API_KEY=your_secret_key"
```

### Multiple Instances (Different Environments)

```bash
# Production
/mcp add company-prod \
  --url https://mcp.company.com/sse \
  --resource https://prod.company.com

# Staging
/mcp add company-staging \
  --url https://mcp.company.com/sse \
  --resource https://staging.company.com
```

### Custom Server Flags

| Flag            | Usage              | Example                                   |
| --------------- | ------------------ | ----------------------------------------- |
| `--url`         | Server URL         | `--url https://api.com/sse`               |
| `--header`      | Auth header        | `--header "Authorization:Bearer token"`   |
| `--env`         | Environment vars   | `--env "KEY=value,KEY2=value2"`           |
| `--resource`    | Resource URL       | `--resource https://tenant.atlassian.net` |
| `--timeout`     | Connection timeout | `--timeout 60000`                         |
| `--description` | Human description  | `--description "My API"`                  |
| `--trust`       | Auto-approve tools | `--trust true`                            |

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
