# AdaL CLI Documentation

<div align="center">
  <img src="docs-site/static/adal-face-logo.png" alt="AdaL Face" width="150" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs-site/static/adal-text-logo.png" alt="AdaL Text" width="280" />
  <br /><br />
  <strong>Your self-evolving agent for engineering and research</strong>
  <br /><br />

  [![Docs](https://img.shields.io/badge/docs-docs.sylph.ai-blue)](https://docs.sylph.ai)
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

This is the **public documentation site** for [AdaL CLI](https://docs.sylph.ai/). AdaL is an agentic coding tool that runs in your terminal, created by [SylphAI](https://sylph.ai/) and named after Ada Lovelace, the world's first programmer.

**What you can do here:**

- Report issues with AdaL CLI agent behavior
- Suggest documentation fixes or improvements
- Contribute to make the docs better

### Install AdaL CLI

```bash
npm install -g @sylphai/adal-cli

# cd to your working directory and run
adal
```

Requires [Node.js 20+](https://nodejs.org/en/download). See [Quickstart](https://docs.sylph.ai/getting-started/quickstart) for details.

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

## Links

- **Docs:** [docs.sylph.ai](https://docs.sylph.ai)
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
