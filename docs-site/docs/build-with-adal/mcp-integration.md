---
sidebar_position: 1
title: How to leverage MCP
---

# How to leverage MCP

MCP (Model Context Protocol) connects AdaL to external tools and data sources. Here's how to make the most of it for your workflows.

## For Personal Projects

### Code & Development

| Use Case | MCP Server | What it does |
|----------|------------|--------------|
| **Browse repos** | `github` | Search code, view PRs, manage issues directly from AdaL |
| **Automate browser testing** | `playwright` | Control browsers for testing, screenshots, scraping |
| **Local file access** | `filesystem` | Read/write files outside your working directory |

**Example workflow**: "Search my GitHub repos for authentication code" → AdaL finds relevant files across all your repositories.

### Databases

| Use Case | MCP Server | What it does |
|----------|------------|--------------|
| **Query PostgreSQL** | `postgres` | Run queries, explore schemas, analyze data |
| **Local SQLite** | `sqlite` | Perfect for local apps and prototypes |

**Example workflow**: "What's the average order value in the last 30 days?" → AdaL queries your database and returns insights.

### Research & Web

| Use Case | MCP Server | What it does |
|----------|------------|--------------|
| **Web search** | `brave-search` | Search the web from within AdaL |
| **Read web pages** | `puppeteer` | Navigate sites, extract content, take screenshots |

---

## For Teams

### Project Management

| Use Case | MCP Server | What it does |
|----------|------------|--------------|
| **Track issues** | `linear` | Create, update, and query issues without leaving AdaL |
| **Code reviews** | `github` | View PRs, add comments, check CI status |
| **Documentation** | `notion` | Search and update team docs |

**Example workflow**: "Create a Linear issue for the auth bug I just fixed, link it to PR #234" → AdaL creates the issue with context.

### Communication

| Use Case | MCP Server | What it does |
|----------|------------|--------------|
| **Slack integration** | `slack` | Post updates, search messages, summarize channels |

**Example workflow**: "Summarize what the team discussed in #engineering today" → AdaL reads and summarizes Slack messages.

### Error Tracking

| Use Case | MCP Server | What it does |
|----------|------------|--------------|
| **Debug errors** | `sentry` | View errors, stack traces, and affected users |

**Example workflow**: "What's causing the spike in 500 errors today?" → AdaL analyzes Sentry data.

---

## Recommended Setups

### Solo Developer
```
linear + github + postgres
```
Full project management, code hosting, and database access in one session.

### Startup Team
```
linear + github + notion + slack + sentry
```
Complete visibility: issues, code, docs, communication, and errors.

### Data Work
```
postgres + brave-search + filesystem
```
Query data, research context, and save results locally.

---

## Getting Started

See [Features → MCP](/features/mcp-support-proposed) for setup instructions.

## Resources

- [MCP Documentation](https://modelcontextprotocol.io)
- [Server Repository](https://github.com/modelcontextprotocol/servers)
- [Awesome MCP Servers](https://github.com/wong2/awesome-mcp-servers)
