---
sidebar_position: 2
title: Models & Billing
description: "AdaL supports 20+ AI models — Claude Sonnet/Opus, GPT-5, Gemini 3, Z.ai GLM, MiniMax, and local models via Ollama. Switch models instantly. Pay-per-token with prompt caching for 50-90% savings."
---

# Models & Billing

AdaL gives you access to the best AI models from leading providers. Switch models instantly with `/model` to match your task needs and budget.

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

## Model Promotions

Active limited-time discounts. Pricing adjustments are applied automatically — no promo code needed.

| Model | Discount | Window | Slug |
|-------|----------|--------|------|
| **Claude Opus 4.7** | **50% off** (launch week) | 2026-04-19 → 2026-04-27 | `claude-opus-4-7` |
| **DeepSeek V4 Pro** | **50% off** (launch week) | 2026-04-25 → 2026-05-02 | `deepseek-v4-pro` |
| **DeepSeek V4 Flash** | **50% off** (launch week) | 2026-04-25 → 2026-05-02 | `deepseek-v4-flash` |
| **Kimi K2.6** | **50% off** (launch week) | 2026-04-25 → 2026-05-02 | `kimi-k2.6` |

> Promotions are sourced from the model registry and may update without notice. Check back here for the latest.

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

> Legend: ⭐ recommended · 🆕 new

### Anthropic (8 models)

- ⭐ 🆕 **Claude Opus 4.7** — latest flagship, 1M context, adaptive thinking. **50% off launch week through Apr 27.** Slug: `claude-opus-4-7`
- ⭐ **Claude Sonnet 4.6** — daily coding workhorse, 200K context. Slug: `claude-sonnet-4-6`
- **Claude Sonnet 4.6 (1M)** — 1M context variant. Slug: `claude-sonnet-4-6-1m`
- ⭐ **Claude Opus 4.6** — complex reasoning, production code. Slug: `claude-opus-4-6`
- 🆕 **Claude Opus 4.6 (1M)** — 1M context variant. Slug: `claude-opus-4-6-1m`
- **Claude Sonnet 4.5** — Slug: `claude-sonnet-4-5-20250929`
- **Claude Opus 4.5** — Slug: `claude-opus-4-5-20251101`
- **Claude Haiku 4.5** — fast, cheap. Slug: `claude-haiku-4-5-20251001`

### OpenAI (8 models)

- 🆕 **GPT-5.4** — Slug: `gpt-5.4`
- ⭐ **GPT-5.3 Codex** — coding-optimized, default baseline. Slug: `gpt-5.3-codex`
- **GPT-5.2** — Slug: `gpt-5.2`
- **GPT-5.2 Codex** — Slug: `gpt-5.2-codex`
- **GPT-5.1 Codex** — Slug: `gpt-5.1-codex`
- **GPT-5.1 Codex Max** — Slug: `gpt-5.1-codex-max`
- **GPT-5 Codex** — Slug: `gpt-5-codex`
- **GPT-5 Mini** — Slug: `gpt-5-mini`

### Google (4 models)

- ⭐ **Gemini 3.1 Pro** — multi-modal reasoning, 1M context. Slug: `gemini-3.1-pro-preview`
- **Gemini 3 Pro** — Slug: `gemini-3-pro-preview`
- ⭐ **Gemini 3 Flash** — ultra-fast, 1M context. Slug: `gemini-3-flash-preview`
- **Gemini 2.5 Pro** — Slug: `gemini-2.5-pro`

### Z.ai GLM (6 models)

- ⭐ **GLM-5** — general coding & reasoning at lower cost. Slug: `glm-5`
- 🆕 **GLM-5-Turbo** — Slug: `glm-5-turbo`
- **GLM-4.7** — Slug: `glm-4.7`
- **GLM-4.7 FlashX** — fast budget coding. Slug: `glm-4.7-flashx`
- **GLM-4.7 Flash** — Slug: `glm-4.7-flash`
- **GLM-4.5 Flash** — Slug: `glm-4.5-flash`

### MiniMax (4 models)

- 🆕 **MiniMax M2.7** — Slug: `minimax-m2.7`
- 🆕 **MiniMax M2.7 Highspeed** — Slug: `minimax-m2.7-highspeed`
- **MiniMax M2.5** — Slug: `minimax-m2.5`
- **MiniMax M2.5 Highspeed** — Slug: `minimax-m2.5-highspeed`

### DeepSeek (2 models)

- 🆕 **DeepSeek V4 Pro** — 936K context, 64K output, adaptive thinking. Strong reasoning at a fraction of the cost. **50% off launch week through May 2.** Slug: `deepseek-v4-pro`
- 🆕 **DeepSeek V4 Flash** — 984K context, 16K output. Fast & budget-friendly thinking for high-volume coding loops. **50% off launch week through May 2.** Slug: `deepseek-v4-flash`

### Moonshot (1 model)

- 🆕 **Kimi K2.6** — 224K context, 32K output, thinking enabled. Strong long-context reasoning. **50% off launch week through May 2.** Slug: `kimi-k2.6`

## Image Models

AdaL also supports image generation and editing. Ask AdaL to generate or edit an image and it will route to the appropriate model automatically.

- ⭐ **GPT Image 2** (OpenAI) — high-fidelity photorealism and excellent in-image text rendering. Up to 4K, all common aspect ratios. Slug: `gpt-image-2`
- ⭐ **Nano Banana 2** (Google) — default general-purpose image generation & editing. Slug: `nano-banana-2`
- ⭐ **Nano Banana Pro** (Google) — professional assets, heavy text rendering. Slug: `nano-banana-pro`
- **Nano Banana** (Google) — stable fallback, speed-optimized. Slug: `nano-banana`
- **Imagen 4** (Google) — Slug: `imagen-4`

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

### Adaptive Thinking & Effort Control

All models use adaptive thinking that automatically scales reasoning depth based on task complexity. Thinking is always on by default and adjusts itself — perfect for debugging, architecture decisions, and complex refactoring.

You can also manually tune the thinking effort level with `/model config`:

```bash
/model config
```

This opens an interactive dialog right in your terminal. Use **arrow keys** (↑↓) to browse the available effort levels for your current model, then press **Enter** to confirm. The dialog shows a description for each level so you know what you're picking:

| Level | Behavior |
|-------|----------|
| **max** | Always thinks with no constraints on depth |
| **high** | Always thinks deeply (default) |
| **medium** | Moderate thinking — may skip for simple queries |
| **low** | Minimal thinking — fastest, lowest cost |

The available levels depend on the model — not all models support every level. The dialog only shows what's valid for your current selection.

**Shortcut:** You can also skip the dialog and set it inline: `/model config effort=high`.

Your effort setting persists per project. Lower effort = faster responses and lower token cost for simple tasks.

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
