---
sidebar_position: 3
title: FAQ
---

# FAQ

## General

**What is AdaL CLI?**
An AI coding agent that executes development tasks autonomously—not just code suggestions.

**System requirements?**
Node.js 20+, npm, internet connection. Platforms: macOS, Windows, Linux.

**Where is configuration stored?**
- Config: `~/.adal/config.json`
- Logs: `~/.adal/logs/`

---

## Models

**What models are supported?**
- Cloud: Claude (Opus, Sonnet, Haiku), GPT-4o, Gemini
- Local: Ollama (qwen3-coder, gpt-oss)

**How to switch models?**
```
/model                  # Open dialog
/model claude-3.5-sonnet # Direct switch
```

**Can I use offline?**
Yes, with local Ollama models (experimental).

---

## Usage

**What can I build?**
Code generation, refactoring, debugging, documentation, testing, API integration—any development task.

**What languages are supported?**
Language-agnostic: JavaScript, Python, Go, Rust, Java, C++, and more.

**Can I use in CI/CD?**
Yes. See [MCP Integrations](../03-features/mcp-support.md) for details.

---

## Pricing

**Is it free?**
- Free tier: Local models unlimited
- Pro ($20/mo): $24 credits
- Max ($100/mo): $130 credits
- Max+ ($200/mo): $300 credits

**Rate limit exceeded?**
Wait for reset, upgrade plan, or use local models.

---

## Security

**Is my code sent externally?**
With cloud models, code context is sent to AI providers. Use local Ollama for maximum privacy.

**How is data protected?**
HTTPS encryption, secure keychain storage for credentials.

---

## MCP Troubleshooting

**"Missing environment variables"**
```bash
export GITHUB_TOKEN="ghp_xxxx"
# Restart adal CLI
```

**OAuth fails or 0 tools available**
1. Restart CLI
2. Try `/mcp → server → Remove Server` then re-add
3. Use HTTP transport: `/mcp add linear --transport http`

**Environment variable not working?**
Restart CLI—env vars are loaded at startup.

---

## Getting Help

- 📖 [GitHub](https://github.com/SylphAI-Inc/adal-cli/issues)
- 💬 [Discord](https://discord.com/invite/ezzszrRZvT)
- 💼 [LinkedIn](https://www.linkedin.com/company/sylphai)
- 📧 contact@sylph.ai
