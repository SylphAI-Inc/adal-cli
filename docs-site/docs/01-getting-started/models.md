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

Switch AI model for this project. 22 models available

Recommended

● Claude Sonnet 4.6 ✓     Anthropic • 200K
○ Claude Opus 4.6         Anthropic • 200K
○ Gemini 3 Pro            Google • 1M
○ Gemini 3 Flash          Google • 1M
○ GPT-5.2 Codex           OpenAI • 400K
○ MiniMax M2.5            MiniMax • 200K
○ MiniMax M2.5 Highspeed  MiniMax • 200K

Providers

○ Anthropic ✓           7 models →
○ OpenAI                8 models →
○ Google                3 models →
○ MiniMax               2 models →
○ Ollama                2 models →

↑↓ navigate · Enter select/open · Press i for info · Esc exit
```

Your selection also applies to future AdaL CLI sessions in this project.

## Pricing

All pricing shown per **million tokens (MTok)**. Caching significantly reduces costs for repeated context.

### Flagship Models

| Model | Provider | Input ($/M) | Output ($/M) | Cache | Best For |
|-------|----------|-------------|--------------|-------|----------|
| **Claude Opus 4.5** | Anthropic | $5 | $25 | 90% off | Complex reasoning, production code |
| **Claude Opus 4.6** | Anthropic | $5 | $25 | 90% off | Latest reasoning, production code |
| **Claude Opus 4.6 (1M)** | Anthropic | $10 | $37.50 | 90% off | Extended context for large codebases |
| **Claude Sonnet 4.5** | Anthropic | $3 | $15 | 90% off | Daily coding, balanced cost |
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

## Local Models (Preview)

Run AI models entirely on your machine — no API key, no cloud costs, no data leaving your device.

AdaL supports local models via [Ollama](https://ollama.ai). Once Ollama is running with a model pulled, select it from `/model` under the **Local** section.

```bash
/model   # scroll to Ollama section → select a model
```

Supported models include `GPT-OSS 20B` and `Qwen3-Coder 30B`. Local models are free to use but require a capable GPU/CPU.

→ **[Full setup guide: Local Models with Ollama](../03-features/local-models.md)**


## Key Features

### Adaptive Thinking
All models use adaptive thinking that automatically scales reasoning depth based on task complexity. There's no toggle—thinking is always on and adjusts itself. Perfect for debugging, architecture decisions, and complex refactoring.

### Prompt Caching
Reusing context (files, conversation history) costs **50-90% less** with cached inputs. Caching is automatic - AdaL handles it behind the scenes.

### Extended Context
Handle large codebases with models supporting up to **1M tokens**:
- Claude Opus 4.6 (1M)
- Gemini 3 Pro (1M)
- Gemini 2.5 Pro (1M)
- GPT-4.1 (1M)

Perfect for reviewing entire repositories or understanding complex systems.

## Billing

AdaL offers two billing options:

1. **AdaL CLI Subscription** - Subscribe with monthly credits included. Use any model seamlessly—credits are deducted automatically based on token usage.

2. **Pro + BYOAK (Bring Your Own API Key)** - Use your own API keys for supported providers (main models or supporting models) while maintaining a Pro subscription (or higher) to ensure all features work seamlessly.

See [Pricing](https://app.adal.ml/subscription) for subscription tiers and credit details.


**Related:** [Quickstart](./quickstart.md) · [Input Methods](./input-methods.md) · [BYOAK](../03-features/bring-your-own-api-key.md)
