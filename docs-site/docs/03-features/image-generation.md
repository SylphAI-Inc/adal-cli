---
sidebar_position: 7
title: Image Generation & Analysis
description: "Generate AI images from text prompts and analyze screenshots directly in AdaL. Uses Google Gemini Nano Banana models. Support for multiple variants, aspect ratios, and resolutions."
---

# AI Image Generation & Analysis

AdaL can generate images from text prompts and analyze existing images directly in your workflow.

## Generate Images

Ask AdaL to create images by describing what you want:

```
Generate an image of a futuristic city at sunset
Draw a cute cartoon dog with a red hat
Create a minimalist logo for a coffee shop
```

AdaL uses Google's Gemini image models (including Nano Banana / `gemini-2.5-flash-image`) to generate high-quality images and saves them to your project directory.

### Variants

Generate multiple variations from the same prompt using the `n` parameter (1–4):

```
Generate 4 variants of a logo design for a tech startup
Create 3 different styles of a mountain landscape
```

When generating multiple variants, files are saved as `name_0.png`, `name_1.png`, etc.

### Aspect Ratios

Supported aspect ratios: `1:1`, `2:3`, `3:2`, `3:4`, `4:3`, `9:16`, `16:9`, `21:9`

```
Generate a 16:9 banner image of an ocean wave
Create a 9:16 phone wallpaper with abstract art
```

### Resolution

Supported output resolutions: `1K`, `2K`, `4K`

## Analyze Images

AdaL can read and analyze existing images — screenshots, diagrams, photos, or any visual content:

```
Read this screenshot and tell me what's wrong with the layout
Analyze the architecture diagram in docs/diagram.png
What does this error screenshot show?
```

You can also paste or drop images directly into AdaL for analysis.

### Supported Formats

PNG, JPEG, GIF, WEBP

## Related

- [Web Search](./web-search.md)
- [Input Methods](../getting-started/input-methods) — Paste and analyze images
- [Slash Commands](./slash-commands.md)
