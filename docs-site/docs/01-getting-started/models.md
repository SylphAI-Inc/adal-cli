---
sidebar_position: 2
title: Models & Billing
description: "AdaL supports 20+ AI models — Claude Sonnet/Opus, GPT-5, Gemini 3, Z.ai GLM, MiniMax, and local models via Ollama. Switch models instantly. Pay-per-token with prompt caching for 50-90% savings."
---

# Models & Billing

AdaL gives you access to the best AI models from leading providers — all in one CLI. Switch models instantly with `/model` to match your task needs and budget.

## Switching Models

```bash
/model
```

Use `/model` to browse four sections:

- **Recommended**: curated top picks for most workflows
- **New**: recently added models
- **Providers**: full model lists grouped by provider
- **Third Party Subscriptions**: OAuth-based third-party model access, such as ChatGPT Subscription

Your selection persists across future AdaL sessions in this project.

## Recommended Models

These are our top picks, balancing capability, speed, and cost:

| Model | Provider | Context | Best For |
|-------|----------|---------|----------|
| **GPT-5.3 Codex** | OpenAI | 272K | Coding-optimized for long-horizon tasks (default, price baseline) |
| **Claude Sonnet 4.6** | Anthropic | 200K | Daily coding (slightly more expensive) |
| **Claude Opus 4.6** | Anthropic | 200K | Complex reasoning, production code (2x more expensive) |
| **Gemini 3.1 Pro** | Google | 1M | Multi-modal reasoning, design tasks (slightly cheaper) |
| **Gemini 3 Flash** | Google | 1M | Ultra-fast, simple tasks (4x in / 5x out cheaper) |
| **GLM-5** | Zai | 200K | General coding and reasoning (2x in / 5x out cheaper) |
| **GLM-4.7 FlashX** | Zai | 200K | Fast budget coding (29x in / 40x out cheaper) |

## All Models by Provider

### OpenAI (8 models)

- **GPT-5.4**
- **GPT-5.3 Codex**
- **GPT-5.2**
- **GPT-5.2 Codex**
- **GPT-5 Mini**
- **GPT-5.1 Codex**
- **GPT-5.1 Codex Max**
- **GPT-5 Codex**

### Anthropic (7 models)

- **Claude Sonnet 4.6**
- **Claude Sonnet 4.6 (1M)**
- **Claude Opus 4.6**
- **Claude Opus 4.6 (1M)**
- **Claude Sonnet 4.5**
- **Claude Opus 4.5**
- **Claude Haiku 4.5**

### Google (4 models)

- **Gemini 3.1 Pro**
- **Gemini 3 Pro**
- **Gemini 3 Flash**
- **Gemini 2.5 Pro**

### Zai (5 models)

- **GLM-5**
- **GLM-4.7**
- **GLM-4.7 FlashX**
- **GLM-4.7 Flash**
- **GLM-4.5 Flash**

### MiniMax (2 models)

- **MiniMax M2.5**
- **MiniMax M2.5 Highspeed**

## Third Party Subscriptions

### ChatGPT Subscription (OAuth)

Use your existing **ChatGPT Plus/Pro** subscription to access Codex models in AdaL — no API key needed. You’ll see this under `/model` → **Third Party Subscriptions**.

→ **[Setup guide: ChatGPT Subscription](../03-features/chatgpt-subscription.md)**

## Local Models (Preview)

Run AI models entirely on your machine — no API key, no cloud costs, no data leaving your device.

AdaL supports local models via [Ollama](https://ollama.ai). Once Ollama is running with a model pulled, select it from `/model` under the **Local** section.

```bash
/model # scroll to Ollama section → select a model
```

Supported models include `GPT-OSS 20B` and `Qwen3-Coder 30B`. Local models are free to use but require a capable GPU/CPU.

→ **[Full setup guide: Local Models with Ollama](../03-features/local-models.md)**

## Key Features

### Adaptive Thinking
All models use adaptive thinking that automatically scales reasoning depth based on task complexity. There's no toggle—thinking is always on and adjusts itself. Perfect for debugging, architecture decisions, and complex refactoring.

### Prompt Caching
Reusing context (files, conversation history) costs **50-90% less** with cached inputs. Caching is automatic — AdaL handles it behind the scenes.

### Extended Context
Handle large codebases with models supporting up to **1M tokens**:
- Claude Sonnet 4.6 (1M) / Opus 4.6 (1M)
- Gemini 3.1 Pro / 3 Pro / Flash / 2.5 Pro

Perfect for reviewing entire repositories or understanding complex systems.

## Billing

AdaL offers two billing options:

1. **AdaL CLI Subscription** — Subscribe with monthly credits included. Use any model seamlessly—credits are deducted automatically based on token usage.

2. **Pro + BYOAK (Bring Your Own API Key)** — Use your own API keys for supported providers while maintaining a Pro subscription (or higher) to ensure all features work seamlessly.

See [Pricing](https://adal.sylph.ai/pricing) for subscription tiers and credit details.

### Pricing Reference

All models use **pay-per-token** pricing based on input and output tokens. Prompt caching reduces costs by **50–90%** on repeated context.

For official pricing from each provider:
- [Anthropic](https://docs.claude.com/en/docs/about-claude/pricing)
- [OpenAI](https://openai.com/api/pricing/)
- [Google](https://ai.google.dev/pricing)
- [MiniMax](https://platform.minimax.io/docs/pricing/pay-as-you-go)

**Related:** [Quickstart](./quickstart.md) · [Input Methods](./input-methods.md) · [BYOAK](../03-features/bring-your-own-api-key.md) · [ChatGPT Subscription](../03-features/chatgpt-subscription.md)
