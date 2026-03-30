---
sidebar_position: 3
title: Deep Research
description: "Conduct deep, multi-source research and produce comprehensive, well-cited reports directly from your terminal or browser."
---

# Deep Research

AdaL can conduct deep, multi-source research and produce comprehensive, well-cited reports — right from your terminal or browser.

Think of it as having a research analyst who searches the web, reads papers, cross-references sources, and writes a polished report with proper citations — all in one session.

## Quick Start (30 seconds)

```bash
# 1. Start AdaL
adal

# 2. Toggle Deep Research Mode
Press Tab

# 3. Enter your research topic
"Research the current landscape of transformer architectures from 2021 to 2026"
```

## Usage

To activate Deep Research mode, press **`Tab`** in the input area before typing your query. The interface will visually indicate that Deep Research is enabled.

Then, describe what you want researched:

```
Research the current landscape of transformer architectures from 2021 to 2026

Compare RAG vs fine-tuning approaches for domain-specific LLM applications

What are the latest advances in protein folding prediction since AlphaFold2?
```

The depth of research depends on how you frame your query — a factual question gets a quick answer, while asking for a comprehensive analysis triggers a full research workflow.

**Tip:** Be specific about scope, time range, and what aspects matter most. A focused query produces a better report.

## Research Depth

AdaL adapts to your query's complexity:

| Depth | When | What You Get |
|-------|------|--------------|
| **Quick** | Factual questions, narrow scope | A few searches, concise answer |
| **Standard** | Comparative analysis, multi-faceted questions | Research plan + structured report |
| **Deep** | Emerging fields, landscape surveys, contested topics | Exhaustive plan + comprehensive report with many sources |

You don't need to specify the level — AdaL infers it. But you can nudge:

```
# Nudge deeper
Give me a comprehensive landscape analysis of vector databases in 2025-2026

# Nudge quicker
Quick summary of what RLHF is and how it works
```

## What to Expect

For substantial queries, AdaL creates a **research plan** in your working directory — outlining the questions to answer, dimensions to cover, and report structure. The plan directly shapes the final report: its sections become the report's sections, and its depth determines how much investigation each area gets.

**The plan evolves.** As AdaL investigates and discovers new angles or dead ends, it revises the plan — adding sections, merging topics, or shifting focus. If you want to steer the research early, check the plan file and tell AdaL what to adjust (e.g., *"Drop the section on pricing and go deeper on performance benchmarks"*).

AdaL then works through multiple rounds of searching, reading, and cross-referencing — not just skimming snippets, but reading full articles and chasing primary sources. You'll see it iterating with progressively sharper queries as it learns what matters.

Once coverage is thorough, AdaL writes a **structured report** section by section. Every factual claim is cited, and a **References** section is automatically generated at the bottom:

```markdown
Transformer architectures have largely converged on the decoder-only
design for language modeling [1], though encoder-decoder models remain
preferred for certain translation tasks [2].

## References

- [1] Attention Is All You Need — Revisited | https://example.com/source1
- [2] Encoder-Decoder vs Decoder-Only | https://example.com/source2
```

Citations are numbered and traceable — click through to verify any claim.

## Tips for Better Results

### Write Specific Prompts

| ✅ Effective | ❌ Too Vague |
|-------------|-------------|
| "Compare RAG vs fine-tuning for medical Q&A, focusing on accuracy, cost, and deployment complexity" | "Tell me about RAG" |
| "Survey Rust web frameworks in 2025-2026, covering performance and ecosystem maturity" | "What Rust web frameworks exist?" |
| "Analyze how attention mechanisms have evolved since the original Transformer paper" | "Explain attention" |

### Guide the Scope

- **Specify time ranges** for fast-moving fields: *"from 2023 to present"*
- **Name the dimensions** you care about: *"focusing on performance, cost, and developer experience"*
- **Mention your audience** if relevant: *"for a technical blog post"* vs *"for a PhD literature review"*

### During Research

- **Let it run.** Deep research takes time — AdaL may search dozens of sources across multiple rounds. This is normal.
- **Use thinking mode** for complex topics: say "think hard" or press Tab to toggle extended reasoning.
- **Check the plan early** if you want to steer the direction before investigation completes.

### After the Report

- **Spot-check citations.** AdaL verifies sources during writing, but a quick review of key claims never hurts.
- **Edit freely.** The report is a markdown file in your directory — refine it however you like.
- **Ask for revisions.** Follow up with: *"Expand the section on retrieval augmentation with more recent benchmarks"* or *"Add a comparison table for the top 3 approaches."*

## Example Queries

| Category | Example |
|----------|---------|
| **Technology survey** | "Research the current state of WebAssembly adoption in production systems" |
| **Comparison** | "Compare PostgreSQL, CockroachDB, and TiDB for distributed OLTP workloads" |
| **Emerging field** | "Survey recent advances in multimodal AI models (2024-2026)" |
| **Best practices** | "Research production best practices for deploying LLMs with RAG pipelines" |
| **Historical analysis** | "How has the Python packaging ecosystem evolved from setuptools to modern tools?" |
| **Contested topic** | "Analyze the debate around AI scaling laws — what do proponents and critics argue?" |

## Output Files

After research completes, you'll find two files in your working directory:

- **Research plan** — the outline with questions, dimensions, and structure
- **Research report** — the full report with citations and references

Both are markdown files named after your research topic (e.g., `vector_databases_plan.md` and `vector_databases_report.md`).

## Related

- [Web Search](https://docs.sylph.ai/features/web-search)
- [Image Generation](https://docs.sylph.ai/features/image-generation)
- [Workflows & Examples](https://docs.sylph.ai/getting-started/workflows-and-examples)
