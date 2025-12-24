---
sidebar_position: 4
title: Bring Your Own API Key
sidebar_label: BYOAK
---

# Bring Your Own API Key (BYOAK)

Use your own LLM provider API keys instead of AdaL credits.

## Supported Providers

| Provider | Key Name |
|----------|----------|
| Anthropic | `ANTHROPIC_API_KEY` |
| OpenAI | `OPENAI_API_KEY` |
| Google AI | `GOOGLE_API_KEY` |

## Quick Start

```bash
/byoak add anthropic sk-ant-your-key-here
```

That's it. Your Anthropic usage now bills directly to your API key.

## Commands

| Command | Description |
|---------|-------------|
| `/byoak` | Open key management dialog |
| `/byoak add <provider> <key>` | Add an API key |

**Dialog shortcuts:**
- `↑/↓` Navigate providers
- `e` Enable/disable key
- `d` Delete key
- `ESC` Close

## How It Works

When you add an enabled API key:
- AdaL connects directly to the provider (no proxy)
- Usage bills to your API key
- No AdaL credits consumed for that provider

When disabled or missing:
- AdaL uses the proxy
- Usage bills to your AdaL credits

## Per-Provider Billing

Each provider is independent. You can:
- Use your own Anthropic key
- Use AdaL credits for OpenAI
- Mix and match as needed

## Get Your API Keys

| Provider | Link |
|----------|------|
| Anthropic | [console.anthropic.com](https://console.anthropic.com/settings/keys) |
| OpenAI | [platform.openai.com](https://platform.openai.com/api-keys) |
| Google AI | [aistudio.google.com](https://aistudio.google.com/apikey) |

## Security

- Keys stored locally in `~/.adal/settings.json`
- Never logged or transmitted (except to provider)
- Masked in UI display

---

**Related:** [Slash Commands](./slash-commands.md) · [Keyboard Shortcuts](./keyboard-shortcuts.md)
