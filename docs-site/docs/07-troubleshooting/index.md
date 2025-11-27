---
sidebar_position: 5
title: Troubleshooting
---

# Troubleshooting

Find solutions to common issues and get answers to frequently asked questions. This section helps you resolve problems quickly and get back to building.

## What You'll Learn

### [Common Issues](./common-issues.md)
Solutions to frequent problems: installation errors, connection issues, model failures, file operation errors, and bash execution problems. Step-by-step troubleshooting guides.

### [FAQ](./faq.md)
Answers to frequently asked questions about AdaL CLI. Learn about privacy, supported platforms, model selection, and more.

---

## Quick Troubleshooting

**Installation Issues:**
- Node.js version too old → Upgrade to Node.js 20+
- Permission denied → Use `sudo npm install -g @sylphai/adal-cli`
- Backend won't start → Check ports 41230-41250 are available

**Connection Problems:**
- Can't connect to backend → Run `/health` to check status
- Authentication failed → Run `/logout` then `/auth` to re-login
- Model timeout → Switch to a faster model with `/model`

**Common Errors:**
- "File not found" → Use absolute paths or check working directory
- "Command failed" → Check bash command syntax and permissions
- "Token limit exceeded" → Use `/compact` to summarize conversation

---

## Getting Help

If you can't find a solution:

1. **Check system health:** `/health`
2. **Report a bug:** `/bug` (auto-generates GitHub issue)
3. **Discord Community:** [discord.com/invite/ezzszrRZvT](https://discord.com/invite/ezzszrRZvT)
4. **Email Support:** contact@sylph.ai
5. **GitHub:** [github.com/SylphAI-Inc](https://github.com/SylphAI-Inc)

---

**Start with:** [Common Issues](./common-issues.md) for solutions to frequent problems.
