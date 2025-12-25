---
sidebar_position: 2
title: Models & Pricing
---

# Models & Pricing

AdaL gives you access to the best AI models from leading providers—all in one CLI. Switch models instantly with `/model` to match your task needs and budget.

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
| **Anthropic** | Claude Opus 4.5, Sonnet 4.5, Haiku 4.5 | Extended thinking, 90% cache discount |
| **Google** | Gemini 3 Pro, 2.5 Pro/Flash/Lite | Multimodal, 1M context, ultra-fast |
| **OpenAI** | GPT-4.1, GPT-4o | 1M context, coding-optimized |

### Coming Soon
- **GPT-5.2** - Next-gen OpenAI reasoning model
- **GPT-5-Codex** - Specialized coding variant
- **Ollama** - Open source local models (FREE, runs offline)

## Pricing

All pricing shown per **million tokens (MTok)**. Caching significantly reduces costs for repeated context.

### Flagship Models

| Model | Input | Cached Input | Output | Best For |
|-------|-------|--------------|--------|----------|
| **Claude Opus 4.5** | $5 | $0.50 (90% off) | $25 | Complex reasoning, production code |
| **Claude Sonnet 4.5** | $3 | $0.30 (90% off) | $15 | Daily coding, thinking mode, best value |
| **Gemini 3 Pro** | $2 | $0.50 (75% off) | $12 | Multimodal, image understanding |
| **Gemini 2.5 Pro** | $1.25 | $0.31 (75% off) | $10 | Multimodal reasoning, 1M context |

### Mid-Tier Models

| Model | Input | Cached Input | Output | Best For |
|-------|-------|--------------|--------|----------|
| **GPT-4.1** | $2 | $0.50 (75% off) | $8 | 1M context, large codebases |
| **GPT-4o** | $2.50 | $1.25 (50% off) | $10 | General purpose, fast responses |
| **Gemini 2.5 Flash** | $0.30 | $0.075 (75% off) | $2.50 | Fast iteration, prototyping |

### Budget Models

| Model | Input | Output | Best For |
|-------|-------|--------|----------|
| **Claude Haiku 4.5** | $1 | $5 | Quick tasks, batch processing |
| **Gemini 2.5 Flash Lite** | $0.10 | $0.40 | Ultra-low cost, high volume |

## Key Features

### Thinking Models
Models with extended reasoning (Claude Sonnet/Opus 4.5, Gemini 3 Pro/2.5 Pro) automatically break down complex problems before answering. Perfect for debugging, architecture decisions, and complex refactoring.

### Prompt Caching
Reusing context (files, conversation history) costs **50-90% less** with cached inputs:
- **Anthropic**: 90% discount on cached tokens
- **OpenAI**: 90% discount (GPT-5), 75% (GPT-4.1)
- **Google**: 75% discount

Caching is automatic—AdaL handles it behind the scenes.

### Extended Context
Handle large codebases with models supporting up to **1M tokens**:
- Claude Sonnet 4.5 (1M)
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

**Related:** [Quickstart](./your-first-session.md) · [Input Methods](./input-methods.md) · [BYOAK](../03-features/bring-your-own-api-key.md)
