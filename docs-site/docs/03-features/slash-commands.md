---
sidebar_position: 0
title: Slash Commands
description: "Complete reference for AdaL CLI slash commands — model switching, MCP server management, session control, plugins, AGENTS.md generation, and more."
---

# Slash Commands

All commands start with `/`. Type `/` and press `Tab` for autocomplete.

## Quick Reference

| Command                | Description                  |
| ---------------------- | ---------------------------- |
| `/help`                | Show help information        |
| `/changelog`           | Show recent changes          |
| `/model`               | Switch AI model              |
| `/clear`               | Clear conversation history   |
| `/resume`              | Resume previous session      |
| `/init [optional msg]` | Generate AGENTS.md file      |
| `/compact`             | Compress conversation memory |
| `/stats`               | Show session statistics      |
| `/mcp`                 | Manage MCP servers           |
| `/bashes`              | List background processes    |
| `/logout`              | Sign out and exit            |
| `/quit`                | Exit AdaL CLI                |
| `/theme`               | Change theme                 |
| `/about`               | Show version and auth status |
| `/bug [desc]`          | Report a bug                 |
| `/byoak`               | Bring your own API keys      |
| `/skills`              | List loaded skills           |
| `/plugin`              | Manage plugins/marketplaces  |
| `/subagent`            | Configure subagents          |
| `/permissions`         | Configure approvals (includes YOLO mode) |


## Tips

- Use `/help` for information of all slash commands.
- Run `/init` to generate AGENTS.md so that AdaL can understand your codebase better.
- Use `/compact` after a milestone is achieved to save context and stay focused, or switch to a larger-context model via `/model` when needed.

**Related:** [MCP](./mcp-support-proposed.md) · [BYOAK](./bring-your-own-api-key.md)
