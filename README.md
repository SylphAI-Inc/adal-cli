# AdaL CLI

<div align="center">
  <img src="assets/adal-face-logo.png" alt="AdaL Face" width="150" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/adal-text-logo.png" alt="AdaL Text" width="280" />
  <br /><br />
  <strong>Your self-evolving agent for engineering and research</strong>
  <br /><br />

  [![Docs](https://img.shields.io/badge/docs-docs.sylph.ai-blue)](https://docs.sylph.ai)
  [![CLI](https://img.shields.io/badge/product-AdaL%20CLI-FF5898)](https://adalagent.ai/product/cli)
  [![Skills](https://img.shields.io/badge/contribute-skills-7057ff)](https://github.com/SylphAI-Inc/skills)
  [![Discord](https://img.shields.io/badge/Discord-join-5865F2?logo=discord&logoColor=white)](https://discord.com/invite/ezzszrRZvT)
  [![X](https://img.shields.io/badge/follow-%40adalagent-black?logo=x)](https://x.com/adalagent)

  <br />

  <a href="https://www.youtube.com/watch?v=szLnhpO9QE8">
    <img src="https://img.youtube.com/vi/szLnhpO9QE8/maxresdefault.jpg" alt="AdaL CLI Demo" width="600" />
  </a>
  <br />
  <a href="https://www.youtube.com/watch?v=szLnhpO9QE8">▶️ Watch the demo on YouTube</a>
</div>

---

## What is AdaL?

AdaL is an AI coding agent that runs in your terminal, created by [SylphAI](https://adalagent.ai/) and named after Ada Lovelace, the world's first programmer. It works with Claude, GPT, Gemini, GLM, Kimi, DeepSeek, MiniMax, and local models.

```bash
npm install -g @sylphai/adal-cli

# cd to your working directory and run
adal
```

Requires [Node.js 20+](https://nodejs.org/en/download). See the [Quickstart](https://docs.sylph.ai/getting-started/quickstart) to get running.

> **This repository is the community home for AdaL CLI** — issues, feature requests, and skills. Use it to report bugs, share what you build, and contribute skills.

## 📖 Documentation — [docs.sylph.ai](https://docs.sylph.ai/)

Everything about installing, configuring, and driving AdaL lives at **[docs.sylph.ai](https://docs.sylph.ai/)**.

| Start here | |
|---|---|
| [Quickstart](https://docs.sylph.ai/getting-started/quickstart) | Install, authenticate, first run |
| [Models & Billing](https://docs.sylph.ai/getting-started/models) | Supported models and pricing |
| [Input Methods](https://docs.sylph.ai/getting-started/input-methods) | Files, images, pasted content |
| [Workflows & Examples](https://docs.sylph.ai/getting-started/workflows-and-examples) | Real end-to-end usage |

| Go deeper | |
|---|---|
| [Slash Commands](https://docs.sylph.ai/features/slash-commands) · [Keyboard Shortcuts](https://docs.sylph.ai/features/keyboard-shortcuts) | Drive the CLI fast |
| [Skills & Plugins](https://docs.sylph.ai/features/plugins-and-skills) | Extend the agent |
| [MCP Servers](https://docs.sylph.ai/features/mcp-support-proposed) | Model Context Protocol |
| [Deep Research](https://docs.sylph.ai/features/deep-research) · [Web Search](https://docs.sylph.ai/features/web-search) | Research from the terminal |
| [Browser Use](https://docs.sylph.ai/features/browser-use) | Drive a real browser |
| [Image Generation & Analysis](https://docs.sylph.ai/features/image-generation) | Create and read images |
| [Headless Mode](https://docs.sylph.ai/features/headless-mode) · [Cron](https://docs.sylph.ai/features/cron-scheduled-prompts) | Scripting, CI, schedules |
| [Local Models](https://docs.sylph.ai/features/local-models) · [BYOAK](https://docs.sylph.ai/features/bring-your-own-api-key) | Run local or bring your own keys |
| [Manage & Resume Sessions](https://docs.sylph.ai/features/manage-conversations) | History, stats, resuming work |

**Also:** [Changelog](https://docs.sylph.ai/changelog) · [Troubleshooting](https://docs.sylph.ai/troubleshooting/linux-clipboard)

## ⚡ The CLI — [adalagent.ai/product/cli](https://adalagent.ai/product/cli)

**Start where developers move fastest.** AdaL CLI brings agentic work into the terminal — with model switching, reviewable tool use, session memory, and IDE handoff.

- **Terminal-native** — a CLI that feels like a product surface: command discovery, tool confirmations, streaming work, and clean recovery paths.
- **Review-first** — tool calls, file edits, diffs, plans, and verification steps stay visible, so you understand the work before signing off.
- **Model freedom** — move between Claude, Gemini, GLM, Kimi, DeepSeek, MiniMax and more through a fast command palette, without provider-specific setup friction.
- **CLI → IDE handoff** — start in the terminal, then open the same session in AdaL's agentic IDE when the task needs files, terminal, and canvas together.

| Command | What it does |
|---|---|
| `/model` | Choose the best model for the job |
| `/ide` | Open the current session in the agentic IDE |
| `/resume` | Return to previous work with context intact |
| `/stats` | Inspect session health, model, and usage |

**The workflow:** describe the task in plain language → AdaL plans, acts, and verifies with tool visibility → switch models or open `/ide` without losing context → review the diff, approve, and ship.

Full details on the [product page](https://adalagent.ai/product/cli).

## 🛠️ Contribute a Skill

**Skills are the best way to contribute to AdaL.** A skill is a markdown file that teaches the agent a repeatable workflow — no need to touch the CLI internals. If you have a process you have refined (a deployment runbook, a review checklist, a framework-specific pattern), it can become a skill other developers install in one command.

Skills live in **[SylphAI-Inc/skills](https://github.com/SylphAI-Inc/skills)** (MIT licensed) and install straight into the CLI:

```bash
/plugin marketplace add SylphAI-Inc/skills
/plugin install core-skills@adal-agent-skills
/skills   # see what you have
```

### How to contribute one

1. **Fork** [SylphAI-Inc/skills](https://github.com/SylphAI-Inc/skills)
2. **Create** your skill at `skills/<your-skill-name>/SKILL.md`
3. **Register** it in `.claude-plugin/marketplace.json` under the appropriate plugin
4. **Open a pull request**

The `SKILL.md` format:

```markdown
---
name: skill-name
description: Brief description for the skills list
author: your-username
version: 1.0.0
---

# Skill Title

## When to Use

Describe the trigger conditions — when should the agent reach for this?

## Instructions

Step-by-step guidance for the agent.
```

New to it? Install the **[create-skill](https://github.com/SylphAI-Inc/skills/blob/main/skills/create-skill/SKILL.md)** skill and let AdaL scaffold one with you. For a large reference example, see **[swe-cli-skills](https://github.com/SylphAI-Inc/swe-cli-skills)** — 20+ expert CLI guides.

### What makes a good skill

- **Encodes judgment, not reference docs** — the gotchas, safety guardrails, error recovery, and anti-patterns a senior engineer would know
- **Has clear trigger conditions** — so the agent knows *when* to use it
- **Is specific** — "deploy a Next.js app to Vercel with preview envs" beats "help with deployment"

## 💬 Share Your Use Case

**We want to see what you build with AdaL.** Real workflows teach us more than any feature request — they show us where the agent helps, where it gets in the way, and what to build next. They also help other developers discover what is possible.

**[Share your use case →](https://github.com/SylphAI-Inc/adal-cli/issues/new)**

Tell us:
- **What you were trying to do** — the task, project, or workflow
- **How you used AdaL** — prompts, skills, models, slash commands
- **What worked, and what didn't** — the honest version is the useful version
- **Anything you would want next**

Screenshots, terminal recordings, and links to the resulting PR are all welcome. Prefer to chat? Post it in **[Discord](https://discord.com/invite/ezzszrRZvT)** or tag **[@adalagent](https://x.com/adalagent)** on X.

## 🐛 Report an Issue

**[Open an Issue →](https://github.com/SylphAI-Inc/adal-cli/issues/new)**

Please include:
- What you expected vs what happened
- Steps to reproduce (if applicable)
- AdaL CLI version (`adal -v`)
- OS and terminal

Looking for somewhere to start? Browse **[good first issues](https://github.com/SylphAI-Inc/adal-cli/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)**.

## Why we build it

[SylphAI](https://adalagent.ai/company) is building **autonomy that humans can trust** — systems where agents execute, memory preserves context, and humans stay aligned with the work.

- **True autonomy** — agents should not replace human judgment; they should move with it, preserving context, trust, and control.
- **Human-aligned automation** — the bottleneck is not generating more work, it is helping humans understand, guide, and validate automated work faster.
- **Developer-first agents** — we start with coding agents because software is where autonomy can be measured, reviewed, and improved every day.

We are a small crew of researchers and builders. If that sounds like your kind of work, email your resume and a note on a project you are proud of to [contact@sylph.ai](mailto:contact@sylph.ai) — more on the [company page](https://adalagent.ai/company).

## Links

- **Docs:** [docs.sylph.ai](https://docs.sylph.ai)
- **CLI product page:** [adalagent.ai/product/cli](https://adalagent.ai/product/cli)
- **Company:** [adalagent.ai/company](https://adalagent.ai/company)
- **Skills marketplace:** [github.com/SylphAI-Inc/skills](https://github.com/SylphAI-Inc/skills)
- **Discord:** [Join our community](https://discord.com/invite/ezzszrRZvT)
- **X (Twitter):** [@adalagent](https://x.com/adalagent)
- **SylphAI:** [adalagent.ai](https://adalagent.ai/)

---

<div align="center">
  <strong>Built by AdaL & <a href="https://adalagent.ai/">SylphAI</a></strong>
</div>
