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

```
> Select Model

  ○ 1. Claude Sonnet 4.5         Anthropic • Thinking • 200K tokens • Default
  ○ 2. Claude Haiku 4.5          Anthropic • Thinking • 200K tokens • Fast
  ○ 3. Claude Sonnet 4.5 (1M)    Anthropic • Thinking • 1M tokens
  ● 4. Claude Opus 4.5           Anthropic • Thinking • 200K tokens
  ○ 5. Gemini 3 Pro (Preview)    Google • Thinking • 1M tokens
  ○ 6. Gemini 3 Flash (Preview)  Google • Thinking • 1M tokens • Fast
  ○ 7. Gemini 2.5 Pro            Google • Thinking • 1M tokens
  ○ 8. GPT-4.1                   OpenAI • 1M tokens
```

Your selection persists for the current project.

## Pricing

All pricing shown per **million tokens (MTok)**. Caching significantly reduces costs for repeated context.

### Flagship Models

| Model | Provider | Input ($/M) | Output ($/M) | Cache | Best For |
|-------|----------|-------------|--------------|-------|----------|
| **Claude Opus 4.5** | Anthropic | $5 | $25 | 90% off | Complex reasoning, production code |
| **Claude Sonnet 4.5** | Anthropic | $3 | $15 | 90% off | Daily coding, thinking mode|
| **Claude Sonnet 4.5 (1M)** | Anthropic | $6 | $22.50 | 90% off | Extended context for large codebases |
| **Gemini 3 Pro** | Google | $2 | $12 | 75% off | Multimodal reasoning, 1M context |
| **Gemini 2.5 Pro** | Google | $1.25 | $10 | 75% off | Multimodal reasoning, 1M context |

### Mid-Tier Models

| Model | Provider | Input ($/M) | Output ($/M) | Cache | Best For |
|-------|----------|-------------|--------------|-------|----------|
| **GPT-4.1** | OpenAI | $2 | $8 | 75% off | 1M context, large codebases |

### Budget Models

| Model | Provider | Input ($/M) | Output ($/M) | Cache | Best For |
|-------|----------|-------------|--------------|-------|----------|
| **Gemini 3 Flash** | Google | $0.50 | $3 | 90% off | Ultra-fast, 1M context |
| **Claude Haiku 4.5** | Anthropic | $1 | $5 | 90% off | Quick tasks |

<!-- ### Coming Soon
- **GPT-5.2** (OpenAI) - Next-gen reasoning model
- **GPT-5-Codex** (OpenAI) - Specialized coding variant
- **Ollama** - Open source local models (FREE, runs offline) -->


## Key Features

### Thinking Models
Models with extended reasoning (Claude Sonnet/Opus 4.5, Gemini 3 Pro/2.5 Pro, etc.) automatically break down complex problems before answering. Perfect for debugging, architecture decisions, and complex refactoring. Toggle thinking mode with `Tab`.

### Prompt Caching
Reusing context (files, conversation history) costs **50-90% less** with cached inputs. Caching is automatic - AdaL handles it behind the scenes.

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
