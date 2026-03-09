---
sidebar_position: 5
title: AdaL Web (Preview)
description: "AdaL Web (Preview) is a browser-based AI coding agent interface. Core capabilities are available today, with full feature parity planned. Launch with adal --web."
---

# AdaL Web (Preview)

AdaL Web is a browser-based interface for AdaL, launched from the same CLI package you already use.

## Launch

Open any terminal, `cd` to your project directory, and run:

```bash
adal --web
```

This automatically opens AdaL in your default browser at `http://localhost:xxxx`. The backend starts automatically — no extra setup needed.

## Features

AdaL Web shares the same agent engine and backend as AdaL CLI. Core capabilities are available today, with full feature parity planned.

### Available Now

- Conduct tasks with all tools, such as read, edit, web search, and bash tools
- Subagent availability
- Toggles for model selection, plan mode, auto-approve edits
- Image upload and select project files as context from the sidebar
- AGENTS.md creation from the sidebar
- One-click memory compaction from the sidebar
- Resume previous conversations from the sidebar
- Diff viewer in the sidebar for reviewing changes

Both AdaL interfaces (CLI and Web) connect to the same backend — your project context, session history, and more are shared.
