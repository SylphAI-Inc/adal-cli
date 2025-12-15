# AGENTS.md

This file provides guidance to agents (i.e., ADAL) when working with code in this repository.

## Repository Overview

This is the **documentation repository** for ADAL CLI, containing the public-facing Docusaurus documentation site. This repo is part of the larger ADAL monorepo ecosystem but maintains its own deployment pipeline.

**Key Context**: This documentation repo depends on and documents code from parent repositories:
- `../adal-cli/`: CLI frontend (React/Ink terminal UI)
- `../deep_research/`: Backend agent logic (AdalFlow library)
- `../tools/`: Tool implementations (file ops, bash, web search)
- `../frontend/`: Web app frontend (Next.js/React)
- `../backend/`: Web app backend (FastAPI/Python)

## Project Structure

```
adal-cli-docs/
├── docs-site/                # Docusaurus documentation site
│   ├── docs/                 # Documentation content
│   │   ├── 01-getting-started/
│   │   ├── 03-features/
│   │   └── 07-troubleshooting/
│   ├── src/                  # Custom React components
│   ├── static/               # Static assets (images, logo)
│   ├── docusaurus.config.ts  # Docusaurus configuration
│   ├── sidebars.ts           # Sidebar navigation structure
│   └── package.json          # Node dependencies and scripts
├── render.yaml               # Render.com deployment config
└── README.md                 # Repository overview
```

## Essential Commands

### Documentation Development

```bash
cd docs-site

# Install dependencies (required first time or after package.json changes)
npm install

# Start development server (auto-reloads on file changes)
npm run start
# Opens browser at http://localhost:3000

# Build for production (outputs to docs-site/build/)
npm run build

# Serve production build locally (test before deploy)
npm run serve

# Type checking
npm run typecheck

# Clear Docusaurus cache (if you see stale content)
npm run clear
```

**Critical Gotchas**:
- **Node version**: Requires Node.js >=18.0 (specified in package.json engines)
- **Working directory**: All npm commands must run from `docs-site/` subdirectory, not repo root
- **Build artifacts**: `docs-site/build/` is auto-generated, never edit directly
- **Cache issues**: If docs don't update, run `npm run clear` then `npm run start` again

## Architecture & Data Flow

### Deployment Pipeline

1. **Local Development**: Edit markdown in `docs-site/docs/` → `npm run start` → preview at localhost:3000
2. **Build**: Docusaurus processes markdown → generates static HTML/JS/CSS → outputs to `docs-site/build/`
3. **Deployment**: Push to `main` branch → Render.com auto-detects changes → runs build command → serves from `build/`

### Configuration Flow

- **docusaurus.config.ts**: Site metadata, navbar, footer, theme settings
  - Site URL: `https://adal-cli-docs.onrender.com`
  - Organization: `SylphAI-Inc`
  - Disabled blog feature (blog: false)
  
- **sidebars.ts**: Controls left sidebar navigation structure
  - Auto-generated from `docs/` folder structure
  - Organized by numeric prefixes (01-getting-started, 03-features, etc.)

### Parent Repository Dependencies

**When documenting features**, you may need to reference:

1. **CLI Commands** (`../adal-cli/`):
   - Entry point: `../adal-cli/packages/cli/src/index.ts`
   - Backend spawning: `../adal-cli/packages/cli/src/utils/apiBackend.ts`
   - Port range: 41230-41250 (dynamic allocation)

2. **Agent Logic** (`../deep_research/`):
   - API endpoints: `../deep_research/api.py`
   - WebThinker: `../deep_research/webthinker.py`
   - Multi-model support: OpenAI, Anthropic, Ollama

3. **Tool System** (`../tools/`):
   - File operations: `../tools/src/file_ops.py`
   - Bash execution: `../tools/src/bash_ops.py`
   - Web search: `../tools/src/search_tools.py`

4. **Web App** (`../frontend/`, `../backend/`):
   - Frontend: Next.js 14, Supabase auth
   - Backend: FastAPI, runs on localhost:8000/8001
   - See `../backend/BILLING_DATA_MODEL.md` for Stripe integration details

**Access Strategy**: When documenting features, use `LocalFileOps_read_file` with relative paths (e.g., `../adal-cli/README.md`) to verify current implementation details.

## Documentation Guidelines

### Content Organization

- **Getting Started** (01-): Installation, first session, basic workflows
- **Features** (03-): Slash commands, keyboard shortcuts, MCP support
- **Troubleshooting** (07-): Common issues and solutions

Use numeric prefixes to control sidebar ordering (Docusaurus sorts alphabetically).

### Markdown Best Practices

- **Code blocks**: Always specify language (```bash, ```typescript, ```python)
- **Headings**: Use ## for main sections, ### for subsections (# is page title)
- **Links**: Use relative paths for internal docs (`../features/slash-commands.md`)
- **Admonitions**: Use Docusaurus admonitions for important notes:
  ```markdown
  :::tip
  Use this for helpful tips
  :::
  
  :::warning
  Use this for important warnings
  :::
  ```

### Cross-Repository Documentation

When documenting features from parent repos:
1. **Verify current state**: Read actual source files, don't rely on memory
2. **Link to source**: Include GitHub links to relevant code when helpful
3. **Keep in sync**: Update docs when parent repo features change
4. **Example commands**: Always test commands before documenting them

## Deployment

### Render.com Configuration

**Build command**: `cd docs-site && npm install && npm run build`
**Publish directory**: `docs-site/build`
**Branch**: `main`

**Environment variables**:
- `NODE_VERSION`: 18.20.0
- `NODE_ENV`: production

**Automatic deployment**: Enabled on push to `main` branch

### Security Headers

Configured in `render.yaml`:
- `X-Frame-Options: SAMEORIGIN`
- `X-Content-Type-Options: nosniff`
- `X-XSS-Protection: 1; mode=block`

## Testing Workflow

Before committing documentation changes:

1. **Local preview**: `cd docs-site && npm run start`
2. **Verify links**: Click through all internal links
3. **Test code examples**: Copy-paste commands to ensure they work
4. **Check parent repos**: If documenting features from `../adal-cli/`, `../deep_research/`, verify implementation details
5. **Build check**: `npm run build` (catches broken links, invalid markdown)
6. **Type check**: `npm run typecheck` (catches TypeScript errors in custom components)

## Common Issues

### Stale Content
**Problem**: Documentation doesn't reflect latest changes
**Solution**: Run `npm run clear` then restart dev server

### Build Failures
**Problem**: `npm run build` fails with broken link errors
**Solution**: Check `docs/` for invalid internal links or missing files

### Missing Dependencies
**Problem**: "Cannot find module" errors
**Solution**: Delete `node_modules/` and `package-lock.json`, run `npm install` fresh

### Port Conflicts
**Problem**: Dev server won't start (port 3000 in use)
**Solution**: Kill existing process or specify different port: `npm run start -- --port 3001`

## Related Documentation

- Parent repo guidelines: `../AGENTS.md`
- CLI README: `../adal-cli/README.md`
- Backend docs: `../deep_research/README.md`, `../backend/README.md`
- Feature specs: `../docs/adal/` (internal design docs)
- Web app docs: `../docs/webapp/`

## Key Entry Points

- **Main config**: `docs-site/docusaurus.config.ts`
- **Navigation**: `docs-site/sidebars.ts`
- **Content root**: `docs-site/docs/`
- **Custom components**: `docs-site/src/components/`
- **Styles**: `docs-site/src/css/custom.css`

## Notes for Agents

1. **Always work from docs-site/ subdirectory** for npm commands
2. **Cross-reference parent repos** when documenting features - read actual code, don't assume
3. **Test all commands** before adding to documentation
4. **Maintain numeric prefixes** in folder names for proper sidebar ordering
5. **Preview locally** before pushing (broken links fail production builds)
6. **Access parent repos** using relative paths like `../adal-cli/`, `../deep_research/`, etc.
7. **Deployment is automatic** - push to main triggers Render.com rebuild
