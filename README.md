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

## About

AdaL is an AI coding agent that runs in your terminal, created by [SylphAI](https://adalagent.ai/) and named after Ada Lovelace, the world's first programmer. It works with Claude, GPT, Gemini, GLM, Kimi, DeepSeek, MiniMax, and local models.

**This repository is the community home for AdaL CLI** — report issues, share what you build, and contribute skills.

### Install AdaL CLI

Native install is recommended: it manages AdaL's runtime and updates consistently across platforms.

**macOS, Linux, WSL:**

```bash
curl -fsSL https://adal.sylph.ai/install.sh | bash
```

**Windows PowerShell:**

```powershell
irm https://adal.sylph.ai/install/windows | iex
```

**Windows CMD:**

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://adal.sylph.ai/install/windows | iex"
```

> If `irm` is not recognized, you are in CMD rather than PowerShell — use the Windows CMD command above, or open PowerShell.

Then go to your working directory and run:

```bash
adal
```

First run opens the browser for authentication. See the [Quickstart](https://docs.sylph.ai/getting-started/quickstart) for details.

## The CLI

**Start where developers move fastest.** AdaL CLI brings agentic work into the terminal — with model switching, reviewable tool use, session memory, and IDE handoff.

- **Terminal-native** — command discovery, tool confirmations, streaming work, and clean recovery paths.
- **Review-first** — tool calls, file edits, diffs, and plans stay visible, so you understand the work before signing off.
- **Model freedom** — switch between Claude, Gemini, GLM, Kimi, DeepSeek, MiniMax and more from a fast command palette.
- **CLI → IDE handoff** — open the same session in AdaL's agentic IDE when a task needs files, terminal, and canvas together.

| Command | What it does |
|---|---|
| `/model` | Choose the best model for the job |
| `/ide` | Open the current session in the agentic IDE |
| `/resume` | Return to previous work with context intact |
| `/stats` | Inspect session health, model, and usage |

More on the [CLI product page](https://adalagent.ai/product/cli).

## Documentation

Everything is published at [docs.sylph.ai](https://docs.sylph.ai/).

**Get started**

| Page | What it covers |
|---|---|
| [Quickstart](https://docs.sylph.ai/getting-started/quickstart) | Install, authenticate, first run |
| [Models & Billing](https://docs.sylph.ai/getting-started/models) | Supported models and pricing |
| [Input Methods](https://docs.sylph.ai/getting-started/input-methods) | Files, images, pasted content |
| [Workflows & Examples](https://docs.sylph.ai/getting-started/workflows-and-examples) | Real end-to-end usage |

**Features**

| Page | What it covers |
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

## 📝 Contributing

Skills are the best way to contribute. A skill is a markdown file that teaches the agent a repeatable workflow — no need to touch the CLI internals.

Skills live in [SylphAI-Inc/skills](https://github.com/SylphAI-Inc/skills) (MIT) and install straight into the CLI:

```bash
/plugin marketplace add SylphAI-Inc/skills
/plugin install core-skills@adal-agent-skills
/skills   # see what you have
```

### Contribute a Skill

1. **Fork** [SylphAI-Inc/skills](https://github.com/SylphAI-Inc/skills)
2. **Create** your skill at `skills/<your-skill-name>/SKILL.md`
3. **Register** it in `.claude-plugin/marketplace.json`
4. **Open a pull request**

```markdown
---
name: skill-name
description: Brief description for the skills list
author: your-username
version: 1.0.0
---

# Skill Title

## When to Use

Describe the trigger conditions.

## Instructions

Step-by-step guidance for the agent.
```

New to it? Install [create-skill](https://github.com/SylphAI-Inc/skills/blob/main/skills/create-skill/SKILL.md) and let AdaL scaffold one with you. For a larger example, see [swe-cli-skills](https://github.com/SylphAI-Inc/swe-cli-skills).

### Share Your Use Case

We want to see what you build. Real workflows show us where the agent helps and what to build next — and help other developers discover what is possible.

**[Share your use case →](https://github.com/SylphAI-Inc/adal-cli/issues/new)**

- What you were trying to do
- How you used AdaL — prompts, skills, models, commands
- What worked, and what didn't
- Anything you would want next

Screenshots and terminal recordings welcome. Prefer to chat? Post in [Discord](https://discord.com/invite/ezzszrRZvT) or tag [@adalagent](https://x.com/adalagent) on X.

## 🐛 Reporting Issues

**[Open an Issue →](https://github.com/SylphAI-Inc/adal-cli/issues/new)**

Please include:
- What you expected vs what happened
- Steps to reproduce (if applicable)
- AdaL CLI version (`adal -v`)
- OS and terminal

New here? Browse [good first issues](https://github.com/SylphAI-Inc/adal-cli/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22).

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
  Built by AdaL & <a href="https://adalagent.ai/">SylphAI</a>
</div>
