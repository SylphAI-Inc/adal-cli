---
sidebar_position: 2
title: Models & Pricing
---

# Models & Pricing

AdaL gives you access to the best AI models from leading providers—all in one CLI. Switch models instantly with `/model` to match your task needs and budget.

> **📋 Note:** Pricing shown below is sourced from official provider documentation for **reference and model comparison only**. It does not directly reflect SylphAI's billing rates. See [Billing](#billing) for how AdaL credits work.

## Switching Models

```bash
/model
```

Select from frontier models optimized for engineering tasks:

![Model Selection](/img/getting-started/model-selection.png)

Your selection persists for the current project.

## Supported Providers

| Provider | Models Available | Key Strength |
|----------|-----------------|--------------|
| **Anthropic** | Claude Opus 4.5/4.6, Sonnet 4.5, Haiku 4.5 | Extended thinking, 90% cache discount |
| **Google** | Gemini 3 Pro, 2.5 Pro/Flash/Lite | Multimodal, 1M context, ultra-fast |
| **OpenAI** | GPT-5.2, GPT-5.1, GPT-5, Codex series, GPT-4.1 | Reasoning, coding-specialized variants |
| **MiniMax** | MiniMax-M2.5, M2.5 Highspeed | Ultra-affordable, Anthropic-compatible API |

### Coming Soon
- **Ollama** - Open source local models (FREE, runs offline)

## Pricing Reference

All pricing shown per **million tokens (MTok)** from official provider documentation. Caching significantly reduces costs for repeated context.

> **⚠️ Disclaimer:** Prices listed below are sourced from each provider's official pricing page for **comparison purposes only**. SylphAI's actual billing rates may differ. See [Billing](#billing) for subscription and credit details.

### Anthropic (Claude)

*Source: [claude.com/pricing](https://docs.claude.com/en/docs/about-claude/pricing)*

| Model | Input ($/M) | Cached Input ($/M) | Output ($/M) | Best For |
|-------|-------------|-------------------|--------------|----------|
| **Claude Opus 4.6** | $5 | $0.50 (90% off) | $25 | Latest flagship, adaptive thinking |
| **Claude Opus 4.5** | $5 | $0.50 (90% off) | $25 | Complex reasoning, production code |
| **Claude Sonnet 4.5** | $3 | $0.30 (90% off) | $15 | Daily coding, thinking mode, best value |
| **Claude Sonnet 4** | $3 | $0.30 (90% off) | $15 | Thinking model |
| **Claude Haiku 4.5** | $1 | $0.10 (90% off) | $5 | Quick tasks, batch processing |

### OpenAI

*Source: [openai.com/api/pricing](https://openai.com/api/pricing/)*

#### Codex (Coding-Specialized)

| Model | Input ($/M) | Cached Input ($/M) | Output ($/M) | Best For |
|-------|-------------|-------------------|--------------|----------|
| **GPT-5.2 Codex** | $1.75 | $0.175 (90% off) | $14 | Best coding model, 400K context |
| **GPT-5.1 Codex** | $1.25 | $0.125 (90% off) | $10 | Coding-optimized, 400K context |
| **Codex Mini** | $1.50 | $0.15 (90% off) | $6 | Cost-effective routine coding |

#### Flagship & Reasoning Models

| Model | Input ($/M) | Cached Input ($/M) | Output ($/M) | Best For |
|-------|-------------|-------------------|--------------|----------|
| **GPT-5.2** | $1.75 | $0.175 (90% off) | $14 | Most capable, 400K context, agentic |
| **GPT-5.1** | $1.25 | $0.125 (90% off) | $10 | Adaptive reasoning, 196K context |
| **GPT-5** | $1.25 | $0.125 (90% off) | $10 | Thinking model, configurable reasoning |
| **GPT-5 Mini** | $0.25 | $0.025 (90% off) | $2 | Budget-friendly reasoning |
| **GPT-4.1** | $2 | $0.50 (75% off) | $8 | 1M context, large codebases |

### Google (Gemini)

*Source: [ai.google.dev/pricing](https://ai.google.dev/pricing)*

| Model | Input ($/M) | Cached Input ($/M) | Output ($/M) | Best For |
|-------|-------------|-------------------|--------------|----------|
| **Gemini 3 Pro** | $2 | $0.50 (75% off) | $12 | Multimodal, image understanding |
| **Gemini 2.5 Pro** | $1.25 | $0.31 (75% off) | $10 | Multimodal reasoning, 1M context |
| **Gemini 2.5 Flash** | $0.30 | $0.075 (75% off) | $2.50 | Fast iteration, prototyping |
| **Gemini 2.5 Flash Lite** | $0.10 | $0.01 (90% off) | $0.40 | Ultra-low cost, high volume |

### MiniMax

*Source: [platform.minimax.io/docs/pricing/pay-as-you-go](https://platform.minimax.io/docs/pricing/pay-as-you-go)*

| Model | Input ($/M) | Cached Input ($/M) | Output ($/M) | Best For |
|-------|-------------|-------------------|--------------|----------|
| **MiniMax-M2.5** | $0.30 | $0.03 (90% off) | $1.20 | Agentic tasks, ultra-affordable |
| **MiniMax-M2.5 Highspeed** | $0.30 | $0.03 (90% off) | $3.60 | Fast responses, competitive pricing |

## Key Features

### Thinking Models
Models with extended reasoning (Claude Sonnet/Opus 4.5+, GPT-5.x, Gemini 3 Pro/2.5 Pro, MiniMax-M2.5) automatically break down complex problems before answering. Perfect for debugging, architecture decisions, and complex refactoring.

### Prompt Caching
Reusing context (files, conversation history) costs **50-90% less** with cached inputs:
- **Anthropic**: 90% discount on cached tokens
- **OpenAI**: 90% discount (GPT-5.x), 75% (GPT-4.1)
- **Google**: 75-90% discount
- **MiniMax**: 90% discount

Caching is automatic—AdaL handles it behind the scenes.

### Extended Context
Handle large codebases with models supporting up to **1M tokens**:
- Claude Opus 4.6 (1M variant available)
- Claude Sonnet 4.5 (1M variant available)
- GPT-5.2 (400K)
- GPT-4.1 (1M)
- Gemini 3 Pro (1M)
- Gemini 2.5 Flash (1M)

Perfect for reviewing entire repositories or understanding complex systems.

## Billing

AdaL offers two billing options:

1. **AdaL CLI Subscription** - Subscribe with monthly credits included. Use any model seamlessly—credits are deducted automatically based on token usage.

2. **Pro + BYOAK (Bring Your Own API Key)** - Use your own API keys for supported providers (main models or supporting models) while maintaining a Pro subscription (or higher) to ensure all features work seamlessly.

See [Pricing](https://app.adal.ml/subscription) for subscription tiers and credit details.

---

**Related:** [Quickstart](./quickstart.md) · [Input Methods](./input-methods.md) · [BYOAK](../03-features/bring-your-own-api-key.md)
