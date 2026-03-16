---
sidebar_position: 9
title: Persistent Memory
description: "Give AdaL long-term memory that persists across sessions. Project context, learned patterns, and coding preferences stored as plain files — version-controlled, shareable, and human-editable."
---

# Persistent Memory

Give AdaL memory that lasts. Instead of re-explaining your project, conventions, and preferences every session, AdaL remembers — and gets better over time.

:::info Proposed Feature
This is a proposed feature for AdaL CLI. Inspired by memory architectures in tools like [Letta](https://github.com/letta-ai/letta-code) (formerly MemGPT). If you'd like to see this implemented, upvote or comment on the [GitHub issue](https://github.com/SylphAI-Inc/adal-cli/issues).
:::

## The Problem

Every new AdaL session starts from scratch. You end up repeating yourself:

```
> We use Bun, not npm. Always use `bun run` and `bun install`.
> Our API follows REST conventions with snake_case.
> Tests go in __tests__/ next to the source file.
> We use Tailwind, don't write raw CSS.
```

`AGENTS.md` partially solves this — but it's all-or-nothing (loaded every session regardless of relevance) and doesn't grow or learn from your interactions.

## The Solution: Memory as Files

Persistent memory is stored as **plain markdown files** in your project and home directory. AdaL reads them at the start of each session, learns from interactions, and writes new knowledge back.

```
.adal/memory/                    # Project memory (git-tracked, shared with team)
├── system/                      # Always loaded into context
│   ├── project/
│   │   ├── overview.md          # What this project is
│   │   ├── architecture.md      # System design
│   │   ├── conventions.md       # Code style and patterns
│   │   └── tooling.md           # Build tools, test framework, linter
│   └── team/
│       └── workflow.md          # PR process, branch naming, deploy steps
├── reference/                   # Loaded on-demand when relevant
│   ├── api-patterns.md          # Common API patterns in this codebase
│   ├── gotchas.md               # Known footguns and workarounds
│   └── solved/
│       ├── auth-timeout.md      # How we fixed the auth timeout
│       └── migration-v2.md      # Notes from the v2 migration
└── .gitignore                   # Ignore personal preferences

~/.adal/memory/                  # Personal memory (follows you everywhere)
├── system/
│   ├── identity.md              # Who you are, your role
│   └── preferences/
│       ├── coding-style.md      # Tabs vs spaces, naming conventions
│       ├── communication.md     # Verbosity, explanation depth
│       └── tools.md             # Preferred tools and frameworks
└── reference/
    └── learnings.md             # Things AdaL learned about you over time
```

### Why Files?

| Approach | AdaL Memory | Database | Vector Store |
|----------|-------------|----------|-------------|
| **Inspect** | Open in any editor | Need a DB client | Need an API |
| **Edit** | Edit like any file | Write SQL/queries | Re-embed |
| **Version** | `git log` | Needs migration | No history |
| **Share** | `git push` | Export/import | Platform-locked |
| **Review** | PR review | Hard to diff | Opaque |
| **Backup** | Already in git | Separate backup | Separate backup |

## Memory Tiers

Inspired by how operating systems manage memory — frequently needed data stays close, everything else is a search away.

### Tier 1: System Memory (Always In Context)

Files under `system/` are injected into AdaL's system prompt every session. Keep these **small, high-signal, and current**.

```
.adal/memory/system/
```

- Loaded automatically at session start
- Counts against your context window
- Target: **~40 lines max per file**, 10-15 files total
- Think of it as RAM — fast access, limited space

**What belongs here:**
- Project overview and architecture
- Active coding conventions
- Current sprint/focus areas
- Team workflow (branch naming, PR process)

**What doesn't belong here:**
- Historical debugging notes (move to `reference/`)
- Rarely-used API docs (move to `reference/`)
- Personal preferences on a team project (use `~/.adal/memory/`)

### Tier 2: Reference Memory (Loaded On Demand)

Files under `reference/` are **not** loaded into context by default. AdaL searches them when your task matches.

```
.adal/memory/reference/
```

- Searchable by the agent when relevant
- Doesn't consume context window until needed
- No size limit — store as much as you want
- Think of it as disk — large capacity, accessed when needed

**What belongs here:**
- Solved problem write-ups
- API reference notes
- Debugging playbooks
- Migration guides
- Historical context

### Tier 3: Recall (Conversation History)

AdaL already persists conversations via `/resume`. Persistent memory extends this with **cross-session search** — find what you discussed last week without knowing which session it was.

```bash
# Search across all past sessions
adal memory search "how did we fix the rate limiter"
# → Found in session abc123 (2026-02-28):
#   "The rate limiter was hitting Redis timeouts because..."
```

## Proposed Commands

### Initialize Memory

```bash
adal memory init
```

Bootstraps the `.adal/memory/` directory by analyzing your codebase:

```
> Scanning codebase...
> Detected: TypeScript, Bun, React, Tailwind, PostgreSQL
> Detected: monorepo with apps/ and packages/
> Generated 18 memory files in .adal/memory/system/

project/overview.md       — SaaS billing platform, monorepo
project/architecture.md   — apps/web (Next.js), apps/api (Hono), packages/db
project/conventions.md    — snake_case APIs, PascalCase components, Zod schemas
project/tooling.md        — Bun, Biome, Vitest, Drizzle ORM
team/workflow.md          — trunk-based, squash merge, deploy on merge to main
```

### View Memory

```bash
# Show memory tree
adal memory status

# Show what's loaded in the current session
adal memory active
```

**In-session slash command:**

```
/memory              # Browse memory files
/memory status       # Show loaded vs available
/memory search <q>   # Search across all memory tiers
```

### Edit Memory

Memory files are plain markdown — edit them with any text editor, IDE, or let AdaL update them during a session.

```bash
# Open memory directory
code .adal/memory/

# Or let AdaL learn from the current session
/memory learn
# → AdaL reviews the session and updates relevant memory files
```

### Teach AdaL

Explicitly tell AdaL to remember something:

```
> Remember: we always use `bun test --coverage` before PRs

AdaL: ✓ Added to .adal/memory/system/project/tooling.md:
  "Run `bun test --coverage` before opening PRs"
```

Or correct the agent and it learns:

```
> No, we use snake_case for API responses, not camelCase

AdaL: ✓ Updated .adal/memory/system/project/conventions.md:
  API responses: snake_case (not camelCase)
```

### Sync Across Devices

**Project memory** syncs automatically via git — it's just files in your repo.

**Personal memory** (`~/.adal/memory/`) can sync via:

```bash
# Initialize personal memory as a git repo
adal memory sync init

# Push to your private remote
adal memory sync push

# Pull on another device
adal memory sync pull
```

Under the hood, this is a standard git repo at `~/.adal/memory/` with a remote you configure once.

## Memory File Format

Each memory file uses YAML frontmatter for metadata, followed by markdown content:

```markdown
---
description: Project coding conventions and style guide
limit: 5000
updated: 2026-03-05
source: learned
---

# Coding Conventions

## Naming
- **API responses**: snake_case
- **React components**: PascalCase
- **Database columns**: snake_case
- **Environment variables**: SCREAMING_SNAKE_CASE

## File Structure
- Tests: `__tests__/` directory next to source
- Components: one component per file
- Hooks: `use` prefix, in `hooks/` directory

## Imports
- Absolute imports via `@/` alias
- Group: external → internal → relative → types
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `description` | Yes | What this memory block contains (used for search) |
| `limit` | Yes | Max character count for this block |
| `updated` | No | Last modification date |
| `source` | No | How this was created: `manual`, `learned`, `init` |
| `read_only` | No | If `true`, the agent cannot modify this file |
| `tags` | No | Searchable tags for reference memory |

## How It Works With Existing Features

### AGENTS.md Compatibility

`AGENTS.md` and persistent memory **complement each other**:

| Feature | AGENTS.md | Persistent Memory |
|---------|-----------|-------------------|
| **Loaded** | Always, fully | System: always / Reference: on-demand |
| **Editable by agent** | No | Yes (agent learns and updates) |
| **Scope** | Repository instructions | Broader context + learned knowledge |
| **Format** | Single file | Hierarchical directory |
| **Best for** | Static rules ("always do X") | Evolving knowledge ("we learned Y") |

Use `AGENTS.md` for hard rules. Use memory for everything else.

### Skills Integration

Skills can **read and write** memory files. A skill for PR reviews could check `project/conventions.md` to enforce your team's style. A debugging skill could write findings to `reference/solved/`.

```yaml
# SKILL.md
name: pr-review
description: Review PRs against team conventions
memoryBlocks: [project/conventions, team/workflow]
```

### Session Resume + Memory

When you `/resume` a session, AdaL loads both the conversation history **and** any memory that was updated during that session. If memory was modified since the session ended (by another team member or on another device), the agent sees the latest version.

## Team Workflows

### Onboarding New Developers

Project memory doubles as living documentation. When a new developer joins:

1. They clone the repo (which includes `.adal/memory/`)
2. AdaL immediately knows the project's architecture, conventions, and tooling
3. No onboarding prompt needed — just start asking questions

```
# New developer's first session
> How is the project structured?

AdaL: Based on the project memory, this is a monorepo with...
(reads from .adal/memory/system/project/architecture.md)
```

### Shared Learnings via Pull Requests

When AdaL learns something new, it writes to memory files. These show up in your PR diff:

```diff
# .adal/memory/reference/solved/rate-limiter-fix.md (new file)
+ ---
+ description: Rate limiter Redis timeout fix
+ limit: 3000
+ source: learned
+ tags: [redis, rate-limiting, performance]
+ ---
+
+ # Rate Limiter Redis Timeout
+
+ ## Problem
+ Rate limiter was timing out under load because...
+
+ ## Solution
+ Switched from per-request Redis calls to a sliding window...
```

Your team reviews these memory updates just like code changes.

### Protected Memory

Mark files as `read_only` to prevent the agent from modifying critical project rules:

```yaml
---
description: Immutable deployment process
limit: 3000
read_only: true
---
```

Only humans can edit `read_only` memory files. The agent can read them but never overwrite them.

## Privacy & Security

| Concern | How It's Handled |
|---------|-----------------|
| **Project secrets** | `.adal/memory/.gitignore` excludes sensitive files |
| **Personal data** | `~/.adal/memory/` stays local (you control syncing) |
| **Team visibility** | `.adal/memory/` is in the repo — everything is reviewable |
| **Agent modifications** | All changes are git-tracked — full audit trail |
| **Accidental overwrites** | `read_only` frontmatter prevents agent writes |

## Getting Started

```bash
# 1. Initialize project memory
adal memory init

# 2. Review generated files
code .adal/memory/

# 3. Commit to git
git add .adal/memory/
git commit -m "feat: initialize AdaL project memory"

# 4. Start a session — AdaL now remembers
adal
```

That's it. AdaL loads project memory automatically on every session. It grows smarter as you work — learning conventions, documenting solutions, and sharing knowledge with your team through git.

**Related:** [Skills & Plugins](./plugins-and-skills.md) · [Manage & Resume Sessions](./manage-conversations.md) · [Session Sharing](./session-sharing.md)
