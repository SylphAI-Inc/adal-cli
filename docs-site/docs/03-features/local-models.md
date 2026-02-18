---
sidebar_position: 6
title: Local Models
---

# Use AdaL with Local Models

Run AI models entirely on your own machine — no API key, no cloud costs, no data leaving your device. AdaL integrates with [Ollama](https://ollama.com) to let you use open-source models locally.

:::info Preview
Local model support is in **preview**. Some features (e.g., image input) are not yet available for local models. Local models are smaller than cloud models and may struggle with complex tasks — if that happens, switch to a cloud model with `/model`.
:::

## Prerequisites

1. **Install Ollama** — download from [ollama](https://ollama.com/download) or:

   ```bash
   curl -fsSL https://ollama.ai/install.sh | sh
   ```

2. **Start the Ollama server:**

   ```bash
   ollama serve
   ```

3. **Pull a model:**

   ```bash
   ollama pull gpt-oss:20b   # good starting point
   ```

## Selecting a Local Model in AdaL

Once Ollama is running with at least one model pulled, open the model selector:

```bash
/model
```

Scroll to the **Ollama** section at the bottom. Select your model — AdaL automatically routes to your local Ollama instance.

## Supported Models

AdaL ships with pre-configured local model profiles:

| Display Name | Ollama Tag | Context | Best For |
|---|---|---|---|
| **GPT-OSS 20B** | `gpt-oss:20b` | 256K | General coding, reasoning |
| **Qwen3-Coder 30B** | `qwen3-coder:30b` | 128K | Code generation, refactoring |

You can pull any Ollama-compatible model and it will be available for selection.

## Hardware Requirements

| Model Size | Minimum VRAM | Recommended |
|---|---|---|
| 7B | 8 GB | 16 GB |
| 14B | 16 GB | 24 GB |
| 30B | 32 GB | 48 GB |

Larger models produce better results but require more memory. On Apple Silicon Macs, unified memory is used — an M3 Max (36–128 GB) handles 30B models well.

## Limitations (Preview)

- **No image input** — local models are text-only
- **Slower response** — depends on your hardware
- **No prompt caching** — no cost savings from caching (but also no cost at all)
- Tool calling quality varies by model

## Troubleshooting

**No reponses?**  
Make sure `ollama serve` is running and you have pulled the model via `ollama pull <model>` before launching AdaL. Check with:
```bash
curl http://localhost:11434/api/tags
```

**Related:** [Models & Pricing](../01-getting-started/models.md)
