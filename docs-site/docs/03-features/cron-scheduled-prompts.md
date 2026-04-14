---
sidebar_position: 4
title: "Cron: Scheduled Prompts"
description: "Automate recurring tasks with /cron — schedule prompts that run at fixed intervals for training monitoring, data pipelines, literature reviews, and more."
---

# Cron: Scheduled Prompts

AdaL can run prompts on a schedule — every 30 seconds, every 5 minutes, every hour. Set it and forget it. Your scheduled prompt goes through the exact same pipeline as manual input, so `@file` references, tool usage, and multi-step reasoning all work identically.

## Quick Start

```bash
# Schedule a prompt to run every 5 minutes
/cron add 5m Check the build logs and report any new errors

# Open the interactive cron manager
/cron

# Stop the running cron
/cron remove
```

## Commands

| Command | Description |
|---------|-------------|
| `/cron` | Open interactive dialog — view status, add, or remove |
| `/cron add <interval> <prompt>` | Schedule a recurring prompt |
| `/cron remove` | Stop and remove the active cron |

### Interval Format

Use `<number><unit>`:

| Unit | Meaning | Example |
|------|---------|---------|
| `s` | Seconds | `30s` — every 30 seconds |
| `m` | Minutes | `5m` — every 5 minutes |
| `h` | Hours | `1h` — every hour |

Minimum: **10 seconds** · Maximum: **24 hours**

## Use Cases

### 🏋️ Training Monitoring

Monitor model training, catch failures early, and handle post-training workflows automatically:

```
/cron 30m Check the training progress and checkpoint using wandb CLI.
If there's a problem, fix it and resume training. When the validation
checkpoint of epoch 3 has been saved, stop training and download the
checkpoint. After downloading, convert and upload to HF, and evaluate
the checkpoint with eval.sh simultaneously. Report eval results to
my email.
```

AdaL acts as an autonomous training supervisor — checking progress, intervening on failures, and executing the full post-training pipeline (download → convert → upload → evaluate) when milestones are reached.

### 🔄 Data Pipeline Monitoring

Run and babysit data processing pipelines with automatic error recovery:

```
/cron 10m Run the whole data processing pipeline, and monitor it.
Fix and resume until it successfully completes.
```

Instead of watching terminal output for hours, AdaL monitors the pipeline, diagnoses failures, applies fixes, and restarts — repeating until the full pipeline succeeds.

### 📚 Automated Literature Search

Build a research bibliography incrementally, one paper at a time:

```
/cron 5m Read @LITERATURE.md for my problem statement and relevant
research. Search web and Google Scholar to find and add the single
most relevant paper that is not already in the list.
```

Every 5 minutes, AdaL reads your current literature list, searches for new relevant work, and appends the best find. After an hour, you have ~12 new curated references without lifting a finger.

### More Ideas

```bash
# Health check a deployed service
/cron 1m curl https://api.example.com/health and report if status != 200

# Watch for CI completion
/cron 30s Check if the GitHub Actions build has completed and report the result

# Periodic git activity summary
/cron 1h Summarize git commits in the last hour and note any large diffs

# Monitor disk usage during a long operation
/cron 5m Check disk usage on /data. If above 90%, identify and suggest files to clean up
```

## Interactive Dialog

Type `/cron` to open the visual manager:

**Level 1 — Status Overview**
- Shows: active/inactive status, interval, prompt preview, run count, skip count, countdown to next fire
- Actions: **Add New** or **Remove** (if active)

**Level 2 — Interval Presets** (after selecting "Add New")

| Preset | Value | Best For |
|--------|-------|----------|
| 30 seconds | `30s` | Quick check-ins, CI polling |
| 5 minutes | `5m` | Regular updates, literature search |
| 30 minutes | `30m` | Training monitoring |
| 1 hour | `1h` | Hourly summaries |
| Custom | — | Any interval you want |

After selecting a preset, your input is pre-filled with `/cron add <interval> ` — just type your prompt.

## How It Works

- **Fires immediately**: When you set a cron, it runs the prompt right away, then repeats at the interval.
- **Smart queueing**: If AdaL is busy when the timer fires, one execution is queued and runs as soon as AdaL finishes. Additional fires while queued are skipped — no prompt flooding.
- **Fresh `@file` content**: `@file` references are re-read on every trigger, so you always get the latest file contents.
- **Full pipeline**: Cron prompts go through the same processing as manual input — `@file` expansion, image detection, tool usage, multi-step reasoning.
- **Chat markers**: Each cron event (started, finished, queued, skipped) appears as a visual marker in your chat history.

## Limitations

- **One cron per session** — setting a new one replaces the current one
- **Session-scoped** — the cron clears when you exit AdaL
- **Not persisted** — cron configurations don't survive restarts (yet)

## Tips

- **Start with a longer interval** and shorten once you're confident the prompt works as expected.
- **Use `@file` references** for context that changes between runs (logs, configs, data files).
- **Write detailed prompts** — cron prompts can be multi-sentence. The more specific you are about success/failure conditions and next steps, the better AdaL handles autonomous operation.
- **Check status** with `/cron` to see run/skip counts and time until next fire.

## Related

- [Slash Commands](./slash-commands.md)
- [Deep Research](./deep-research.md)
- [Keyboard Shortcuts](./keyboard-shortcuts.md)
