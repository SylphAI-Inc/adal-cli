---
sidebar_position: 5
title: ChatGPT Subscription
description: "Connect your ChatGPT Plus or Pro subscription to use GPT Codex models in AdaL — no API key needed."
sidebar_label: ChatGPT Subscription
---

# ChatGPT Subscription

Connect your existing ChatGPT Plus or Pro subscription to AdaL via OAuth. No API key needed — just log in with your ChatGPT account and start using GPT Codex models with your existing subscription credits.

## Connect Your Subscription

1. Run `/model` to open model selection
2. Scroll to **Third Party Subscriptions** → select **ChatGPT Subscription**
3. Select **Connect ChatGPT Account** — your browser will open
4. Log in with your ChatGPT account (Plus or Pro required)
5. Once authorized, the dashboard will show **Connected** with your account email

## Available Models

When connected, the following models appear under **ChatGPT Subscription** in `/model`:

| Model | Best For |
|-------|----------|
| **GPT-5.3 Codex** | Latest Codex model, best for complex tasks |
| **GPT-5.2 Codex** | Ideal for large code generation |
| **GPT-5.1 Codex** | Reliable coding assistant |
| **GPT-5.1 Codex Max** | Extended reasoning for hard problems |
| **GPT-5 Codex** | Stable baseline Codex model |

Select any model from the dashboard to switch to it.

## Manage Connection

From `/model` → **Third Party Subscriptions** → **ChatGPT Subscription**, you can:

- **Refresh Status** — Re-check connection and token validity
- **Disconnect** — Remove OAuth tokens from your machine (your ChatGPT subscription stays active)

Tokens refresh automatically in the background. You only need to reconnect if your session fully expires.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Not connected" after login | Wait a few seconds for authorization to complete, then try again |
| Connection expired | Go to `/model` → ChatGPT Subscription → reconnect |
| No models shown | Ensure you have ChatGPT Plus or Pro (free tier not supported) |

## Security

- OAuth tokens are stored locally in `~/.adal/openai_oauth.json`
- Only your account email is stored — no passwords
- Disconnect anytime to revoke access

**Related:** [Models](../01-getting-started/models.md) · [BYOAK](./bring-your-own-api-key.md) · [Slash Commands](./slash-commands.md)
