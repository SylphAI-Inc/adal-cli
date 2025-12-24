# AGENTS.md

This file provides guidance to agents (i.e., ADAL) when working with code in this repository.

## Repository Overview

This is the **public documentation site** for AdaL CLI, built with Docusaurus. It's a standalone documentation repo separate from the main AdaL codebase.

**Main codebase**: See `../adal/AGENTS.md` for guidance on working with the core AdaL CLI, backend, and tools.

## Project Structure

```
adal-cli-public/
├── docs-site/          # Docusaurus site
│   ├── docs/           # Documentation content (markdown)
│   ├── blog/           # Blog posts
│   ├── src/            # React components and custom pages
│   ├── static/         # Static assets (images, etc.)
│   └── build/          # Generated static site (gitignored)
├── INPUT_GUIDE.md      # User guide for input methods (created during docs work)
└── README.md           # Repository overview
```

## Essential Commands

All commands run from `docs-site/` directory:

```bash
cd docs-site

# Install dependencies (first time or after package.json changes)
npm install

# Start development server with hot reload
npm run start
# Opens at http://localhost:3000

# Build static site for production
npm run build
# Output in docs-site/build/

# Serve built site locally (must build first)
npm run serve

# Clear Docusaurus cache
npm run clear

# Type checking
npm run typecheck
```

### Critical Gotchas

- **Node version**: Requires Node >=18.0 (check with `node --version`)
- **Working directory**: Commands must run from `docs-site/` directory, not repo root
- **No tests**: This is a pure documentation site - no test suite
- **Build before serve**: `npm run serve` requires running `npm run build` first

## Documentation Structure

### Content Organization

Documentation lives in `docs-site/docs/` with this structure:

- `01-getting-started/` - Installation, setup, first steps
- `03-features/` - Feature documentation
- `07-troubleshooting/` - Common issues and solutions
- `build-with-adal/` - Advanced usage and examples

### Adding/Editing Documentation

1. **Create new doc**: Add `.md` or `.mdx` file in appropriate subdirectory
2. **Front matter**: Each doc needs front matter:
   ```markdown
   ---
   title: Page Title
   sidebar_position: 1
   ---
   ```
3. **Sidebar config**: Edit `docs-site/sidebars.ts` if you need custom sidebar ordering
4. **Preview changes**: Use `npm run start` to see changes live at http://localhost:3000

### Markdown Features

Docusaurus supports:
- Standard markdown
- MDX (React components in markdown)
- Admonitions (:::note, :::tip, :::warning, :::danger)
- Code blocks with syntax highlighting
- Tabs and other interactive elements

## Configuration Files

- `docs-site/docusaurus.config.ts` - Main Docusaurus configuration (site metadata, navbar, footer, theme)
- `docs-site/sidebars.ts` - Documentation sidebar structure
- `docs-site/package.json` - Dependencies and npm scripts
- `docs-site/tsconfig.json` - TypeScript configuration

## Key Entry Points

- **Docusaurus config**: `docs-site/docusaurus.config.ts` - controls site title, navbar, footer, plugins
- **Homepage**: `docs-site/src/pages/index.tsx` - custom React landing page
- **Custom styles**: `docs-site/src/css/custom.css` - global CSS variables and overrides
- **Static assets**: `docs-site/static/` - images, logos, favicon

## Docusaurus-Specific Patterns

### Internal Links

Use relative paths without `.md` extension:
```markdown
[Getting Started](../getting-started/installation)
```

### Images

Place in `docs-site/static/img/` and reference from markdown:
```markdown
![Alt text](/img/screenshot.png)
```

### Admonitions

```markdown
:::note
This is a note
:::

:::tip
Helpful tip here
:::

:::warning
Be careful!
:::
```

## Common Tasks

### Preview Documentation Locally

```bash
cd docs-site
npm install  # if first time
npm run start
```

Site opens at http://localhost:3000 with hot reload.

### Add New Documentation Page

1. Create `.md` file in appropriate `docs-site/docs/` subdirectory
2. Add front matter with title and sidebar position
3. Write content using Markdown/MDX
4. Check preview with `npm run start`

### Update Navigation

- **Navbar**: Edit `docusaurus.config.ts` → `themeConfig.navbar`
- **Sidebar**: Edit `sidebars.ts` or use `sidebar_position` in front matter

### Build for Production

```bash
cd docs-site
npm run build
npm run serve  # Test built site locally
```

## Relationship to Main Codebase

This documentation site describes the **AdaL CLI** tool (the main product), but lives in a **separate repository** from the AdaL CLI source code.

- **This repo** (`adal-cli-public`): Public documentation only
- **Main repo** (`../adal/`): AdaL CLI source, backend, tools, private docs

When documenting:
- Focus on **user-facing features** and **how-to guides**
- Avoid implementation details (those belong in main repo's private docs)
- Keep examples practical and tested

## Workflow Notes

- **No tests**: Documentation-only repo, no testing infrastructure
- **No linting**: Standard Docusaurus setup, no custom linters configured
- **Git branch**: Currently on `new-branch` - merge to main when ready

## Reference Parent Repo

For context about the actual AdaL CLI implementation:
- Main AGENTS.md: `../adal/AGENTS.md`
- Feature specs: `../adal/docs/adal/fea_*.md`
- Source code: `../adal/adal-cli/`, `../adal/deep_research/`, `../adal/tools/`
