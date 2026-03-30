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

## Research Depth

AdaL automatically adapts to your query's complexity:

| Depth | When | What You Get |
|-------|------|--------------|
| **Quick** | Factual questions, narrow scope | A few searches, concise answer |
| **Standard** | Comparative analysis, multi-faceted questions | Research plan + structured report |
| **Deep** | Emerging fields, landscape surveys, contested topics | Exhaustive plan + comprehensive report with many sources |

*Tip: You can manually nudge AdaL (e.g., "Give me a comprehensive landscape analysis..." or "Quick summary of...").*

## What to Expect

For substantial queries, AdaL executes a multi-step workflow:

1. **Research Plan**: Creates a dynamic outline (`[topic]_plan.md`) in your working directory. You can edit this early to steer the direction.
2. **Investigation**: Iterates through multiple rounds of searching, reading full articles, and cross-referencing sources.
3. **Structured Report**: Writes a final report (`[topic]_report.md`) section by section. Every factual claim is cited, generating a traceable **References** section at the bottom.

## Tips for Better Results

- **Write Specific Prompts**: "Compare RAG vs fine-tuning for medical Q&A, focusing on accuracy and cost" is better than "Tell me about RAG".
- **Guide the Scope**: Specify time ranges (*"from 2023 to present"*) and target audience (*"for a technical blog"*).
- **Ask for Revisions**: Follow up with *"Expand the section on retrieval augmentation"* or *"Add a comparison table"*.

## Example Queries

- **Technology Survey**: "Research the current state of WebAssembly adoption in production systems"
- **Comparison**: "Compare PostgreSQL, CockroachDB, and TiDB for distributed OLTP workloads"
- **Codebase Strategy**: "Compare RAG vs fine-tuning for our specific data pipeline"
- **Repo Analysis**: "Deep analyze the source code of [GitHub Repo] and summarize its architecture"

## Related

- [Web Search](./web-search.md)
- [Image Generation](./image-generation.md)
- [Workflows & Examples](../01-getting-started/workflows-and-examples.md)
