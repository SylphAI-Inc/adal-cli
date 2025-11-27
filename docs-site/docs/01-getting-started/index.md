---
sidebar_position: 0
title: Welcome
---

# Welcome to AdaL CLI

> **TL;DR:** AdaL CLI is your AI-powered terminal teammate that writes code, debugs issues, and ships features—all from natural language. Start free with local models or scale with cloud AI.

---

## What is AdaL CLI?

**An agentic coding assistant** that lives in your terminal. Unlike autocomplete tools, AdaL can:

- **Plan and execute multi-step tasks** - "Add authentication to my API with tests"
- **Search the web** - Finds and applies best practices
- **Run commands safely** - Bash, git, npm with your approval
- **Understand your codebase** - Analyzes structure and patterns
- **Integrate with tools** - Linear, GitHub, Notion via MCP

**Built on [AdalFlow](https://github.com/SylphAI-Inc/AdalFlow)** - a PyTorch-inspired library for building LLM applications.

---

## Key Features

| Feature              | Description                                          |
| -------------------- | ---------------------------------------------------- |
| **Natural Language** | Talk like a teammate—no special syntax               |
| **Multi-File Ops**   | Coordinated changes across entire codebase           |
| **Web Research**     | Search internet, fetch docs without leaving terminal |
| **Local + Cloud**    | Free Ollama models or paid Claude/GPT                |
| **MCP Integrations** | Linear, GitHub, Notion, Slack, PostgreSQL            |
| **Safety First**     | Approval required for all dangerous operations       |

---

## Quick Start (3 Steps)

### 1. Install

```bash
npm install -g @sylphai/adal-cli
```
**Requires:** Node.js 20+ · macOS, Windows, or Linux

### 2. Launch

```bash
cd your-project
adal
```
First run: browser opens for authentication, backend auto-spawns.

### 3. Try It

```
> Create a REST API endpoint for user registration with validation and tests
```

[Detailed installation →](../07-troubleshooting/installation.md) · [Quickstart →](./your-first-session.md) · [Workflows & Examples →](./workflows-and-examples.md)

---

## Model Options

| Type             | Models                     | Best For               |
| ---------------- | -------------------------- | ---------------------- |
| **Local**        | Ollama (experimental)      | Learning, private code |
| **Cloud**        | Claude Sonnet/Opus, GPT-4o | Complex tasks, speed   |
| Feature          | AdaL CLI                   | GitHub Copilot         | Cursor   | Claude Code   |
| ---------        | ----------                 | ----------------       | -------- | ------------- |
| Multi-step tasks | ✅                          | ⚠️ Limited              | ✅        | ✅             |
| Bash execution   | ✅                          | ✅                      | ✅        | ✅             |
| Local models     | ✅ Ollama                   | ❌                      | ⚠️        | ❌             |
| MCP integrations | ✅                          | ✅                      | ❌        | ✅             |
| Terminal-native  | ✅                          | ❌                      | ❌        | ✅             |
| Free tier        | ✅ Unlimited                | ❌                      | ❌        | ❌             |

---

## What's Next?

1. **[Installation Troubleshooting →](../07-troubleshooting/installation.md)** - Detailed setup
2. **[Quickstart →](./your-first-session.md)** - Essential commands
3. **[Workflows & Examples →](./workflows-and-examples.md)** - Practical development patterns
4. **[Features →](../03-features/index.md)** - Advanced capabilities

---

## Getting Help

- 💬 [Discord Community](https://discord.com/invite/ezzszrRZvT)
- 📖 [GitHub](https://github.com/SylphAI-Inc)
- 💼 [LinkedIn](https://www.linkedin.com/company/sylphai)
- 📧 contact@sylph.ai
