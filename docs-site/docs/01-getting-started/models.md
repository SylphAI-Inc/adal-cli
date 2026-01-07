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
| **Google** | Gemini 3 Pro, 3 Flash, 2.5 Pro | Multimodal, 1M context, ultra-fast |
| **OpenAI** | GPT-4.1 | 1M context, coding-optimized |

### Coming Soon
- **GPT-5.2** - Next-gen OpenAI reasoning model
- **GPT-5-Codex** - Specialized coding variant
- **Ollama** - Open source local models (FREE, runs offline)

## Pricing

All pricing shown per **million tokens (MTok)**. Caching significantly reduces costs for repeated context.

### Flagship Models

| Model | Input ($/M) | Output ($/M) | Cache Discount | Best For |
|-------|-------------|--------------|----------------|----------|
| **Claude Opus 4.5** | $5 | $25 | 90% off | Complex reasoning, production code |
| **Claude Sonnet 4.5** | $3 | $15 | 90% off | Daily coding, thinking mode, best value |
| **Claude Sonnet 4.5 (1M)** | $6 | $22.50 | 90% off | Extended context for large codebases |
| **Gemini 3 Pro** | $2 | $12 | 75% off | Multimodal reasoning, 1M context |
| **Gemini 2.5 Pro** | $1.25 | $10 | 75% off | Multimodal reasoning, 1M context |

### Mid-Tier Models

| Model | Input ($/M) | Output ($/M) | Cache Discount | Best For |
|-------|-------------|--------------|----------------|----------|
| **GPT-4.1** | $2 | $8 | 75% off | 1M context, large codebases |

### Budget Models

| Model | Input ($/M) | Output ($/M) | Cache Discount | Best For |
|-------|-------------|--------------|----------------|----------|
| **Gemini 3 Flash** | $0.50 | $3 | 90% off | Quick tasks, 1M context |
| **Claude Haiku 4.5** | $1 | $5 | 90% off | Quick tasks |


## Key Features

### Thinking Models
Models with extended reasoning (Claude Sonnet/Opus 4.5, Gemini 3 Pro/2.5 Pro, etc.) automatically break down complex problems before answering. Perfect for debugging, architecture decisions, and complex refactoring.

### Prompt Caching
Reusing context (files, conversation history) costs **50-90% less** with cached inputs. Caching is automatic—AdaL handles it behind the scenes.

### Extended Context
Handle large codebases with models supporting up to **1M tokens**:
- Claude Sonnet 4.5 (1M)
- Gemini 3 Pro (1M)
- Gemini 2.5 Flash (1M)
- GPT-4.1 (1M)

Perfect for reviewing entire repositories or understanding complex systems.

## Billing

AdaL offers two billing options:

1. **AdaL CLI Subscription** - Subscribe with monthly credits included. Use any model seamlessly—credits are deducted automatically based on token usage.

2. **Pro + BYOAK (Bring Your Own API Key)** - Use your own API keys for supported providers (main models or supporting models) while maintaining a Pro subscription (or higher) to ensure all features work seamlessly.

See [Pricing](https://app.adal.ml/subscription) for subscription tiers and credit details.


**Related:** [Quickstart](./quickstart.md) · [Input Methods](./input-methods.md) · [BYOAK](../03-features/bring-your-own-api-key.md)
