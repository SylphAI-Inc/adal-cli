---
sidebar_position: 3
title: Deep Research
description: "Conduct deep, multi-source research and produce comprehensive, well-cited reports directly from your terminal or browser."
---

# Deep Research

AdaL conducts deep, multi-source research and produces comprehensive, well-cited reports. Unlike standalone tools (like OpenAI Deep Research), AdaL combines live web search with your **local project context** to solve highly specific engineering problems.

## Quick Start (30 seconds)

```bash
# 1. Start AdaL
adal

# 2. Toggle Deep Research Mode
Press Tab (You will see "Deep Research" in the footer)

# 3. Enter your research topic
"Research the current landscape of transformer architectures from 2021 to 2026"
```

## Key Advantages

- **Context-Grounded Research**: Merges your local codebase and files with live web searches.
- **GitHub Deep Analysis**: Ask AdaL to clone and deep dive into relevant Git repos to map out architectures and source code.
- **Auto-Illustrations**: Need diagrams or visuals in your report? Just ask AdaL to "add illustrations" and it will generate them using the Nano Banana image model.

## Recommended Models

For the best Deep Research experience, we highly recommend using top-tier models with large context windows:
- **GPT-5.4**
- **Claude Opus 4.6**
- **Gemini 3.1 Pro**

## What to Expect

1. **Research Plan**: AdaL creates a markdown plan outlining the questions to answer and the report structure.
2. **Investigation**: It iterates through multiple rounds of searching, reading, and cross-referencing.
3. **Structured Report**: It writes a final report section by section, complete with numbered citations and a References list.

## Current Limitations

- **Text-Only Web Extraction**: Currently, our web fetch tool extracts text but does not pull original images from source websites.
- **Knowledge Cutoffs**: Like OpenAI Deep Research, models have inherent training cutoffs and rely entirely on the web search tool to discover the absolute newest models or events.

## Example Queries

- **Technology Survey**: "Research the current state of WebAssembly adoption in production systems"
- **Codebase Strategy**: "Compare RAG vs fine-tuning for our specific data pipeline"
- **Repo Analysis**: "Deep analyze the source code of [GitHub Repo] and summarize its architecture"

## Output Files

Check your working directory for two generated files:
- `[topic]_plan.md`
- `[topic]_report.md`

## Related

- [Web Search](./web-search.md)
- [Image Generation](./image-generation.md)
- [Workflows & Examples](../01-getting-started/workflows-and-examples.md)
