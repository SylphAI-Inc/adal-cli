---
sidebar_position: 2
title: Models & Billing
description: "AdaL supports 24+ AI models — Claude Sonnet/Opus, GPT-5, Gemini 3, MiniMax, and local models via Ollama. Switch models instantly. Pay-per-token with prompt caching for 50-90% savings."
---

# Models & Billing

AdaL gives you access to the best AI models from leading providers — all in one CLI. Switch models instantly with `/model` to match your task needs and budget.

## Switching Models

```bash
/model
```

Select from frontier models optimized for engineering tasks:

```
> Select Model

Switch AI model for this project. 24 models available

Recommended

● Claude Sonnet 4.6 ✓     Anthropic • 200K
○ Claude Opus 4.6         Anthropic • 200K
○ Gemini 3.1 Pro          Google • 1M
○ Gemini 3 Flash          Google • 1M
○ GPT-5.2 Codex           OpenAI • 400K
○ MiniMax M2.5            MiniMax • 200K
○ MiniMax M2.5 Highspeed  MiniMax • 200K

Providers

○ Anthropic ✓           7 models →
○ OpenAI               11 models →
○ Google                4 models →
○ MiniMax               2 models →

↑↓ navigate · Enter select/open · Press i for info · Esc exit
```

Your selection persists across future AdaL sessions in this project.

## Recommended Models

These are our top picks, balancing capability, speed, and cost:

| Model | Provider | Context | Best For |
|-------|----------|---------|----------|
| **Claude Sonnet 4.6** | Anthropic | 200K | Daily coding, cost-effective reasoning |
| **Claude Opus 4.6** | Anthropic | 200K | Complex reasoning, production-quality code |
| **Gemini 3.1 Pro** | Google | 1M | Flagship reasoning, advanced agentic capabilities |
| **Gemini 3 Flash** | Google | 1M | Ultra-fast responses, budget-friendly |
| **GPT-5.2 Codex** | OpenAI | 400K | Coding-optimized, large codebase support |
| **MiniMax M2.5** | MiniMax | 200K | Strong reasoning at competitive pricing |
| **MiniMax M2.5 Highspeed** | MiniMax | 200K | Strong and fast |

## All Models by Provider

### Anthropic (7 models)

- **Claude Sonnet 4.6** — Default model, adaptive thinking, 200K context
- **Claude Sonnet 4.6 (1M)** — Extended 1M context for large codebases
- **Claude Opus 4.6** — Top-tier reasoning, 200K context
- **Claude Opus 4.6 (1M)** — Extended 1M context variant
- **Claude Sonnet 4.5** — Previous generation, solid all-rounder
- **Claude Opus 4.5** — Previous generation flagship
- **Claude Haiku 4.5** — Fast and lightweight for quick tasks

### OpenAI (11 models)

- **GPT-5.2** — Latest GPT model, 400K context
- **GPT-5.2 Codex** — Coding-optimized, 128K output, 400K context
- **GPT-5.1** — Previous generation, 196K context
- **GPT-5.1 Codex** — Coding-focused, 400K context
- **GPT-5.1 Codex Max** — Extended reasoning Codex variant
- **GPT-5** — 200K context
- **GPT-5 Mini** — Fast and affordable, 128K context
- **GPT-5 Codex** — Coding-focused, 200K context
- **o4 Mini** — Fast reasoning model, 200K context
- **GPT-4.1** — 1M context, large codebase support
- **GPT-4.1 Mini** — 1M context, large codebase support

### Google (4 models)

- **Gemini 3.1 Pro** — Latest flagship reasoning, 1M context, advanced agentic capabilities
- **Gemini 3 Pro** — Previous flagship reasoning, 1M context, multimodal
- **Gemini 3 Flash** — Ultra-fast, 1M context, best value
- **Gemini 2.5 Pro** — Legacy generation, 1M context

### MiniMax (2 models)

- **MiniMax M2.5** — Strong reasoning at competitive pricing, 200K context
- **MiniMax M2.5 Highspeed** — Faster variant, optimized for speed

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
- GPT-4.1

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
