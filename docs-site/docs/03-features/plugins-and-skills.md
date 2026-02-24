---
sidebar_position: 3.5
title: Skills & Plugins
description: "Extend AdaL with Skills — reusable domain expertise for coding agents. Compatible with Claude Code skills. Install from Anthropic, Hugging Face, and community marketplaces. Create custom skills for your team."
---

# Skills

**Skills** are reusable, filesystem-based resources that provide the agent with domain-specific expertise: workflows, context, and best practices that transform general-purpose agents into specialists.

:::tip Compatibility
AdaL skills are compatible with [Claude Code skills](https://code.claude.com/docs/en/skills). You can use any Claude Code skill repository with AdaL.
:::

## What Are Skills?

Think of Skills as a hybrid of **[MCP](./mcp-support-proposed.md)** and **[AGENTS.md](https://agents.md/)**:
- Unlike [AGENTS.md](https://agents.md/) (which loads all project context upfront), Skills load **on-demand** when relevant
- Unlike [MCP](./mcp-support-proposed.md) servers (which require running processes), Skills are **simple markdown files** with optional bash scripts for tools

This means you don't need to repeatedly provide the same guidance across conversations—the agent discovers and loads the right expertise automatically.

**Key characteristics:**
- **Filesystem-based**: Skills live in folders containing `SKILL.md` and optional supporting files
- **On-demand loading**: Agent searches and loads skills when your task matches
- **Tool integration**: Skills can include bash scripts that the agent executes as tools

### Skill Sources

Skills come from three places:

| Source | Location | Use Case |
|--------|----------|----------|
| **Personal** | `~/.adal/skills/` | Your custom skills |
| **Project** | `.adal/skills/` | Team skills shared via git |
| **Plugin** | `~/.adal/plugin-cache/` | External skills from GitHub |

### Understanding the Hierarchy

For external skills, there's a three-level structure:

```
Marketplace (GitHub repo, e.g., anthropics/skills)
    └── Plugin (skill group, e.g., document-skills)
            └── Skill (individual capability, e.g., xlsx, docx, pdf)
```

- **Marketplace**: A GitHub repository containing one or more plugins. Add with `/plugin marketplace add`.
- **Plugin**: A group of related skills. Install with `/plugin install` or via the `/plugin` dialog.
- **Skill**: An individual capability. Used automatically by the agent.

**Example:** The [anthropics/skills](https://github.com/anthropics/skills) marketplace contains the `document-skills` plugin, which includes skills for `xlsx`, `docx`, `pptx`, and `pdf`.

## Teams Can Use Skills to Share Knowledge

Turn your feature docs and technical specs into skills. The agent loads them automatically when relevant, so you:

- **Skip repetitive context** — No more pasting the same background for every task
- **Share knowledge** — Team patterns and conventions become discoverable
- **Avoid missed dependencies** — Cross-feature context loads automatically

**Example:** Your team has `payment-flow.md` documenting the checkout process. As a skill, the agent loads it automatically when you work on payment-related code.

## Quick Start & Commands

### `/skills` - View All Active Skills

Shows **all skills** the agent can currently see and use, from all sources:
- Personal skills (`~/.adal/skills/`)
- Project skills (`.adal/skills/`)
- Plugin skills (installed from marketplaces)

### `/plugin` - Manage External Skills

Manages external skills from different marketplaces (GitHub repositories):

| Step | Command | Description |
|------|---------|-------------|
| 1 | `/plugin marketplace add <owner/repo>` | **Add a marketplace** (one-time setup) |
| 2 | `/plugin` | Browse available plugins and marketplaces |
| 3 | `/plugin install <plugin>@<marketplace>` | Install a plugin (or use dialog) |
| 4 | `/skills` | View all active skills |
| 5 | *Use naturally* | The agent invokes skills when relevant |

**Example workflow:**
```bash
/plugin marketplace add anthropics/skills    # Add marketplace
/plugin                                       # Browse & install via dialog
/skills                                       # See installed skills
> Create a PowerPoint presentation           # Agent uses pptx skill automatically
```

**Other commands:**
| Command | Description |
|---------|-------------|
| `/plugin marketplace remove <name>` | Remove a marketplace |
| `/plugin uninstall <plugin>@<marketplace>` | Uninstall a plugin |

> **Note:** The `<marketplace>` in install/uninstall refers to the marketplace **name** (from `marketplace.json`), not the GitHub repo. For example, `anthropics/skills` repo → marketplace name `anthropic-agent-skills`.

## Interactive Dialogs

### Skills Browser (`/skills`)

View all installed skills grouped by source:

```
> Skills (Page 1/2)

Personal (~/.adal/skills/):
  my-custom-skill

Project (.adal/skills/):
→ team-workflow

Plugins:
  xlsx (document-skills@anthropic-agent-skills)
  docx (document-skills@anthropic-agent-skills)
  pptx (document-skills@anthropic-agent-skills)
  pdf (document-skills@anthropic-agent-skills)
```

### Plugin Browser (`/plugin`)

Navigate with arrow keys, press Enter to view details or install:

```
> Plugins

anthropic-agent-skills:
→ ✓ document-skills (installed)
  ○ example-skills

huggingface-skills:
  ○ model-trainer
  ○ dataset-creator

Tips:
  /plugin install <name>@<repo> to install
  /plugin marketplace add <owner/repo> to add repository
```

## Example Skill Repositories

### Anthropic Official Skills

**Repository:** [github.com/anthropics/skills](https://github.com/anthropics/skills)

```bash
/plugin marketplace add anthropics/skills
```

**Collections:**
- `document-skills` - Excel, Word, PowerPoint, PDF processing
- `example-skills` - Algorithmic art, frontend design, MCP builder

### Hugging Face Skills

**Repository:** [github.com/huggingface/skills](https://github.com/huggingface/skills)

```bash
/plugin marketplace add huggingface/skills
```

**Collections:**
- `model-trainer` - Train/fine-tune LLMs using TRL on HF Jobs
- `hugging-face-paper-publisher` - Publish research papers
- `hugging-face-dataset-creator` - Create and manage datasets

### Community Resources

- **[Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills)** - Curated community skills
- **[Skills Marketplace](https://skillsmp.com/)** - 25k+ community skills

## Creating Your Own Skills

### Personal Skills (`~/.adal/skills/`)

Create a folder with a `SKILL.md` file:

```bash
mkdir -p ~/.adal/skills/my-skill
```

**~/.adal/skills/my-skill/SKILL.md:**
```yaml
name: my-skill
description: Brief description of what this skill does and when to use it

# My Skill

## When to Use
Describe when the agent should use this skill.

## Instructions
Provide step-by-step instructions for the agent to follow.
```

### Advanced: Multi-file Skill Structure

Skills can bundle additional resources that the agent loads as needed. The agent discovers supporting files through links in your `SKILL.md`.

**Content types:**
- **Instructions** - Additional markdown files (FORMS.md, REFERENCE.md) with specialized guidance and workflows
- **Code** - Executable scripts (fill_form.py, validate.py) that the agent runs via bash; scripts provide deterministic operations without consuming context
- **Resources** - Reference materials like database schemas, API documentation, templates, or examples

The agent accesses these files only when referenced. Each content type has different strengths: **instructions** for flexible guidance, **code** for reliability, **resources** for factual lookup.

**Example: pdf-skill**
```
pdf-skill/
├── SKILL.md        # Main instructions (required)
├── FORMS.md        # Form-filling guide
├── REFERENCE.md    # Detailed API reference
└── scripts/
    └── fill_form.py    # Utility script
```

In your `SKILL.md`, link to supporting files:
```markdown
For form filling, see [FORMS.md](./FORMS.md).
For API details, see [REFERENCE.md](./REFERENCE.md).
To fill a form: `python scripts/fill_form.py`
```

The agent reads linked files when relevant and executes scripts via bash.

### Project Skills (`.adal/skills/`)

Same format, but in your project directory. These are shared with your team via git.

```bash
mkdir -p .adal/skills/team-workflow
```

## Skill Priority

When skills have the same name, first-loaded wins:
1. **Personal** (`~/.adal/skills/`) - highest priority
2. **Project** (`.adal/skills/`)
3. **Plugin** (`~/.adal/plugin-cache/`) - lowest priority

## Storage Locations

| Path | Purpose |
|------|---------|
| `~/.adal/plugin-cache/` | Cloned marketplace repos |
| `~/.adal/skills/` | Personal skills |
| `.adal/skills/` | Project-specific skills |
| `~/.adal/settings.json` | Plugin settings |


## Skills vs Other Approaches

| Approach | Pros | Cons |
|----------|------|------|
| **Skills** | On-demand loading, no running processes, team-shareable via git | Markdown-based (not real-time APIs) |
| **MCP Servers** | Real-time API access, standard protocol | Requires running processes, more setup |
| **AGENTS.md** | Simple, always loaded | All-or-nothing (no selective loading) |

Use **Skills** for domain expertise and workflows, **MCP** for real-time tool access, and **AGENTS.md** for project-wide context. They complement each other.

**Related:** [Slash Commands](./slash-commands.md) · [MCP Servers](./mcp-support-proposed.md) · [Workflows & Examples](../01-getting-started/workflows-and-examples.md)
