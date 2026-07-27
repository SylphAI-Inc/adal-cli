# AdaL CLI Documentation

<div align="center">
  <img src="docs-site/static/adal-face-logo.png" alt="AdaL Face" width="150" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs-site/static/adal-text-logo.png" alt="AdaL Text" width="280" />
  <br /><br />
  <strong>Your self-evolving agent for engineering and research</strong>
  <br /><br />

  [![Docs](https://img.shields.io/badge/docs-docs.sylph.ai-blue)](https://docs.sylph.ai)
  [![Company](https://img.shields.io/badge/company-adalagent.ai-FF5898)](https://adalagent.ai/company)
  [![Discord](https://img.shields.io/badge/Discord-join-5865F2?logo=discord&logoColor=white)](https://discord.com/invite/ezzszrRZvT)
  [![X](https://img.shields.io/badge/follow-%40adalengineer-black?logo=x)](https://x.com/adalengineer)

  <br />

  <a href="https://www.youtube.com/watch?v=szLnhpO9QE8">
    <img src="https://img.youtube.com/vi/szLnhpO9QE8/maxresdefault.jpg" alt="AdaL CLI Demo" width="600" />
  </a>
  <br />
  <a href="https://www.youtube.com/watch?v=szLnhpO9QE8">▶️ Watch the demo on YouTube</a>
</div>

---

## About

This is the **public documentation site** for [AdaL CLI](https://docs.sylph.ai/) — the source behind [docs.sylph.ai](https://docs.sylph.ai/).

AdaL is an AI coding agent that runs in your terminal, created by [SylphAI](https://sylph.ai/) and named after Ada Lovelace, the world's first programmer. It works with Claude, GPT, Gemini, GLM, MiniMax, and local models.

### Why we build it

[SylphAI](https://adalagent.ai/company) is building **autonomy that humans can trust** — systems where agents execute, memory preserves context, and humans stay aligned with the work.

- **True autonomy** — agents should not replace human judgment; they should move with it, preserving context, trust, and control.
- **Human-aligned automation** — the bottleneck is not generating more work, it is helping humans understand, guide, and validate automated work faster.
- **Developer-first agents** — we start with coding agents because software is where autonomy can be measured, reviewed, and improved every day.

Read more on the [company page](https://adalagent.ai/company).

### Install AdaL CLI

```bash
npm install -g @sylphai/adal-cli

# cd to your working directory and run
adal
```

Requires [Node.js 20+](https://nodejs.org/en/download). See the [Quickstart](https://docs.sylph.ai/getting-started/quickstart) for details.

## Documentation

Everything below is published at [docs.sylph.ai](https://docs.sylph.ai/).

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
| [Slash Commands](https://docs.sylph.ai/features/slash-commands) | In-session commands |
| [Keyboard Shortcuts](https://docs.sylph.ai/features/keyboard-shortcuts) | Terminal shortcuts |
| [Manage & Resume Sessions](https://docs.sylph.ai/features/manage-conversations) | History, stats, resuming work |
| [MCP Servers](https://docs.sylph.ai/features/mcp-support-proposed) | Model Context Protocol integration |
| [Skills & Plugins](https://docs.sylph.ai/features/plugins-and-skills) | Extend the agent |
| [Deep Research](https://docs.sylph.ai/features/deep-research) | Multi-step research runs |
| [Web Search](https://docs.sylph.ai/features/web-search) | Live search from the CLI |
| [Browser Use](https://docs.sylph.ai/features/browser-use) | Drive a real browser |
| [Image Generation & Analysis](https://docs.sylph.ai/features/image-generation) | Create and read images |
| [Headless Mode](https://docs.sylph.ai/features/headless-mode) | Scripting and CI |
| [Cron: Scheduled Prompts](https://docs.sylph.ai/features/cron-scheduled-prompts) | Run prompts on a schedule |
| [Local Models (Ollama)](https://docs.sylph.ai/features/local-models) | Run fully local |
| [Bring Your Own API Key](https://docs.sylph.ai/features/bring-your-own-api-key) | Use your own provider keys |
| [ChatGPT Subscription](https://docs.sylph.ai/features/chatgpt-subscription) | Use an existing ChatGPT plan |

**Also:** [Changelog](https://docs.sylph.ai/changelog) · [Troubleshooting](https://docs.sylph.ai/troubleshooting/linux-clipboard) · [Desktop App (Preview)](https://docs.sylph.ai/getting-started/desktop-app)

## 🐛 Reporting Issues

Found a bug or something wrong in the docs?

**[Open an Issue →](https://github.com/SylphAI-Inc/adal-cli/issues/new)**

Please include:
- What you expected vs what happened
- Steps to reproduce (if applicable)
- AdaL CLI version (`adal -v`)
- OS and terminal

## 📝 Contributing

We welcome documentation improvements!

### Quick Edits

1. Find the page you want to fix at [docs.sylph.ai](https://docs.sylph.ai)
2. Locate the corresponding file in `docs-site/docs/`
3. Edit and submit a PR

### Running Locally

```bash
cd docs-site
npm install
npm run start    # Dev server at http://localhost:3000
npm run build    # Production build
```

### Guidelines

- Keep docs clear and concise
- Test changes locally with `npm run build`
- Follow existing formatting conventions

## Project Structure

```
docs-site/
├── docs/                    # Documentation pages (markdown)
│   ├── 01-getting-started/  # Quickstart, models, workflows
│   ├── 03-features/         # Feature docs (shortcuts, commands, skills)
│   ├── 07-troubleshooting/  # Common issues and solutions
│   └── build-with-adal/     # Advanced usage
├── static/                  # Images and assets
└── src/                     # Custom CSS and components
```

## Careers

We are a small crew of researchers and builders working at the edge of what is useful and possible. Email your resume and a note on a project you are proud of to [contact@sylph.ai](mailto:contact@sylph.ai) — details on the [company page](https://adalagent.ai/company).

## Links

- **Docs:** [docs.sylph.ai](https://docs.sylph.ai)
- **Company:** [adalagent.ai/company](https://adalagent.ai/company)
- **GitHub:** [github.com/SylphAI-Inc/adal-cli](https://github.com/SylphAI-Inc/adal-cli)
- **X (Twitter):** [@adalengineer](https://x.com/adalengineer)
- **Discord:** [Join our community](https://discord.com/invite/ezzszrRZvT)
- **SylphAI:** [sylph.ai](https://sylph.ai)

---

<div align="center">
  <!-- <strong>Star <a href="https://github.com/SylphAI-Inc/adal-cli">AdaL CLI</a> · Follow <a href="https://x.com/adalengineer">@adalengineer</a></strong>
  <br /> -->
  Built with <a href="https://docusaurus.io/">Docusaurus</a> by AdaL & <a href="https://sylph.ai">SylphAI</a>
</div>
