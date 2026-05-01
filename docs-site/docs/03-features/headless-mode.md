---
sidebar_position: 11
title: "Headless Mode"
description: "Run AdaL programmatically without the interactive TUI — pipe queries, get structured output, and integrate AdaL into scripts, CI/CD pipelines, and automation workflows."
---

# Headless Mode

AdaL's headless mode lets you run queries programmatically without the interactive terminal UI. Pass a prompt, get a result — as plain text, structured JSON, or a real-time NDJSON stream. It uses the exact same backend, tools, and agent as the interactive CLI, so everything works identically: file edits, web search, code execution, multi-step reasoning.

Use headless mode to integrate AdaL into shell scripts, CI/CD pipelines, editor extensions, or any automation workflow.

## Prerequisites

Headless mode requires authentication. Run `adal` interactively once — your credentials are cached at `~/.adal/adal_oauth_creds.json` and reused automatically by headless mode.

```bash
# Log in interactively first
adal
# Then headless works
adal -q "explain this codebase"
```

## Quick Start

```bash
# Simple query — prints the final answer to stdout
adal -q "what does main.py do?"

# Pipe input — reads from stdin when not a TTY
cat bug_report.txt | adal

# JSON output — structured response with metadata
adal -q "list all TODO comments" -o json

# Stream events in real-time as NDJSON
adal -q "refactor the auth module" -o stream-json

# Auto-approve all tool calls (no confirmation prompts)
adal -q "fix the failing test" --yolo

# Use a specific model
adal -q "review this PR" -m claude-sonnet-4-20250514

# Resume a previous conversation
adal -q "now add tests for that" -r <session-id>
```

## CLI Flags

| Flag | Short | Description |
|------|-------|-------------|
| `--query <text>` | `-q` | The prompt to execute. Triggers headless mode. |
| `--output <format>` | `-o` | Output format: `text` (default), `json`, or `stream-json`. |
| `--model <name>` | `-m` | Override the default model (e.g., `claude-sonnet-4-20250514`). |
| `--yolo` | — | Auto-approve **all** tool calls. No confirmation prompts. |
| `--allowed-tools <csv>` | — | Auto-approve specific tool groups (comma-separated). |
| `--resume <id>` | `-r` | Resume a previous conversation by session ID. |
| `--prompt <text>` | `-p` | System prompt override. |


## Stdin / Pipe Support

AdaL detects when input is piped (non-TTY stdin) and automatically reads it as the query:

```bash
# Pipe a file as the query
cat bug_report.txt | adal

# Pipe command output
git diff | adal -o json

# Combine with flags
echo "explain this error" | adal --yolo -o json
```

When piped, AdaL reads the entire stdin buffer and uses it as the prompt. The final answer goes to stdout, so you can chain it with other commands.

## Output Formats

### `text` (default)

Prints only the final answer to stdout. Ideal for piping into other commands.

```bash
adal -q "summarize README.md" | pbcopy
```

```
This project is a REST API for managing user accounts...
```

### `json`

Returns a structured JSON object with the answer and metadata. Useful for programmatic consumption.

```bash
adal -q "what's the test coverage?" -o json
```

```json
{
  "success": true,
  "answer": "Current test coverage is 87%. The uncovered files are...",
  "model": "claude-sonnet-4-20250514",
  "session_id": "a1b2c3d4-...",
  "exit_code": 0
}
```

On failure:

```json
{
  "success": false,
  "answer": null,
  "error": "Authentication failed",
  "model": null,
  "session_id": "a1b2c3d4-...",
  "exit_code": 1
}
```

### `stream-json`

Streams events as [NDJSON](https://github.com/ndjson/ndjson-spec) (one JSON object per line) in real-time. Best for building integrations that need live progress updates.

```bash
adal -q "fix the lint errors" -o stream-json
```

```jsonl
{"type":"tool_call","name":"grep","args":{"pattern":"TODO","path":"src/"}}
{"type":"tool_result","name":"grep","status":"success"}
{"type":"tool_call","name":"replace_by_string","args":{"file_path":"src/app.ts","old_string":"var x","new_string":"const x"}}
{"type":"tool_result","name":"replace_by_string","status":"success"}
{"type":"answer","content":"Fixed 3 lint errors in src/app.ts..."}
{"type":"complete","exit_code":0,"session_id":"a1b2c3d4-...","model":"claude-sonnet-4-20250514"}
```

#### NDJSON Event Types

| Type | Fields | Description |
|------|--------|-------------|
| `tool_call` | `name`, `args` | A tool is being invoked |
| `tool_result` | `name`, `status` | A tool completed (`success` / `error`) |
| `answer` | `content` | The agent's final answer |
| `error` | `message` | An error occurred |
| `complete` | `exit_code`, `session_id`, `model` | Stream finished. Always the last event. |

## Tool Approval

In interactive mode, AdaL pauses and asks you to confirm before running tools that modify files or execute commands. In headless mode there's no TUI for approval dialogs, so you control permissions upfront.

### YOLO Mode

Auto-approve everything. The agent runs without any confirmation prompts.

```bash
adal -q "refactor the database layer" --yolo
```

:::caution
YOLO mode allows the agent to execute any tool — including file writes, deletions, and shell commands — without asking. Use it in trusted environments (e.g., ephemeral CI containers, sandboxed workspaces).
:::

### Allowed Tools

Selectively auto-approve specific tool groups while blocking others:

```bash
# Only allow read operations and grep
adal -q "analyze the codebase" --allowed-tools "Read,Grep"

# Allow reads, edits, but not bash
adal -q "fix the typos" --allowed-tools "Read,Grep,Edit"
```

#### Tool Groups

| Group | Tools Included |
|-------|---------------|
| `Read` | `read_file`, `read_image` |
| `Grep` | `grep` |
| `Glob` | `glob` |
| `Edit` | `replace_by_string`, `rewrite_file`, `delete_lines`, `create_file` |
| `Bash` | `bash`, `get_bash_output` |
| `Search` | `web_search`, `fetch_url` |
| `Image` | `generate_image` |

If a tool isn't in the allowed list and isn't safe by default, the agent skips it and proceeds without that action.

## Multi-Turn Conversations

Use `--resume` (`-r`) to continue a previous session:

```bash
# First query
adal -q "explain the auth flow" -o json
# Response includes session_id: "abc-123"

# Follow-up using the same session
adal -q "now add rate limiting to it" -r abc-123
```

The resumed session retains full conversation history, so the agent has context from previous turns.

## Headless Subcommands

Beyond `-q` queries, AdaL exposes subcommands that work entirely in headless mode without launching the TUI.

### Worktree Management

Create isolated git worktrees for parallel headless tasks — each worktree gets its own branch and working directory, so the agent can work without disturbing your main tree.

```bash
# Create a new worktree for a task
adal worktree create fix-auth-bug

# List active worktrees
adal worktree list

# Remove a worktree when done
adal worktree remove fix-auth-bug
```

Worktrees are ideal for CI pipelines that run multiple agent tasks in parallel on separate branches.

### Plugin Management

Install, list, and manage plugins and skills without the interactive UI:

```bash
# List installed plugins
adal plugin list

# Install a plugin from the marketplace
adal plugin install <plugin-name>

# Reload skills after manual changes
adal plugin reload-skills
```

## Environment Variables

These environment variables affect headless mode behavior:

| Variable | Description |
|----------|-------------|
| `ADAL_BACKEND_URL` | Connect to an already-running backend instead of spawning one. Useful for shared server setups. |
| `ADAL_APP_URL` | Platform URL for auth and billing (default: `https://adal.sylph.ai`). Set to `http://localhost:3000` for local development. |
| `ADAL_DEV_MODE` | When `true`, enables development features like `--ralph` mode and verbose logging. |
| `GITHUB_ACTIONS` | Auto-detected. Adjusts workspace sync behavior for CI environments. |
| `GITLAB_CI` | Auto-detected. Same CI adjustments as `GITHUB_ACTIONS`. |

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success — query completed, answer returned |
| `1` | Failure — auth error, model switch failed, or agent error |

## Practical Examples

### CI/CD: Auto-fix Lint Errors

```bash
#!/bin/bash
result=$(adal -q "fix all ESLint errors in src/" --yolo -o json)
if echo "$result" | jq -e '.success' > /dev/null; then
  git add -A && git commit -m "fix: auto-fix lint errors"
fi
```

### GitHub Actions: Automated Code Review

```yaml
- name: Run AdaL code review
  run: |
    adal -q "review the changes in this PR for bugs and security issues" \
      --allowed-tools "Read,Grep" \
      --yolo \
      -o json > review.json
```

:::note
CI/CD token-based auth (`--token`) is coming soon. For now, inject cached credentials in your CI workflow — see the [engineering spec](https://github.com/SylphAI-Inc/adal/blob/main/docs/adal/headless/fea_headless_mode.md) for the workaround pattern.
:::

### Script: Batch Code Review

```bash
#!/bin/bash
for file in src/*.ts; do
  echo "Reviewing $file..."
  adal -q "review $file for bugs and security issues" -o text >> review.md
  echo "---" >> review.md
done
```

### Pipeline: Stream Progress to a Dashboard

```bash
adal -q "migrate the database schema" --yolo -o stream-json | while IFS= read -r line; do
  type=$(echo "$line" | jq -r '.type')
  case "$type" in
    tool_call)  echo "🔧 $(echo "$line" | jq -r '.name')" ;;
    error)      echo "❌ $(echo "$line" | jq -r '.message')" ;;
    answer)     echo "✅ Done" ;;
  esac
done
```

### Pipe: Analyze Error Logs

```bash
# Pipe logs directly to AdaL for analysis
tail -100 /var/log/app.log | adal --yolo -o text

# Pipe a git diff for review
git diff HEAD~1 | adal -o json
```

### Parallel Tasks with Worktrees

```bash
# Run two agent tasks in parallel on separate branches
adal worktree create task-a
adal worktree create task-b

(cd .adal-worktrees/task-a && adal -q "implement feature A" --yolo) &
(cd .adal-worktrees/task-b && adal -q "implement feature B" --yolo) &
wait

adal worktree remove task-a
adal worktree remove task-b
```

### Editor Extension: Get Inline Suggestions

```bash
# Get a JSON response for programmatic use
adal -q "suggest a better name for the function on line 42 of utils.ts" -o json \
  | jq -r '.answer'
```

## Architecture

Under the hood, headless mode uses the same backend as interactive AdaL:

```
adal -q "query"
  │
  ├─ Start backend (same deep_research server)
  ├─ Authenticate (cached JWT from prior login)
  ├─ Sync workspace context
  ├─ Set allowed tools / YOLO permissions
  ├─ POST /webthinker/stream (SSE)
  │   ├─ Agent reasons, calls tools, streams events
  │   └─ Final answer emitted
  ├─ Format output (text / json / stream-json)
  └─ Cleanup and exit
```

### Interactive vs. Headless

| Aspect | Interactive | Headless |
|--------|-------------|----------|
| **UI** | Full React TUI (OpenTUI) | No UI — stdout only |
| **Tool approval** | Interactive dialog | Pre-configured (`--yolo` or `--allowed-tools`) |
| **Session** | Long-lived, multi-turn | Single query (or resumed with `-r`) |
| **Output** | Rich terminal rendering | Plain text, JSON, or NDJSON |
| **Auth** | Device code flow (browser) | Cached JWT from prior login |
| **Backend** | Same `deep_research` server | Same `deep_research` server |
| **Tools & Agent** | Identical | Identical |

### Packaging

Headless mode is **not a separate package** — it's part of the unified `adal` CLI binary. The same `adal` command handles both interactive and headless execution:

- When invoked with `-q`/`--query` or piped stdin → headless path (`headless-launcher.ts`)
- When invoked without flags → interactive TUI

The CLI is bundled into a single JavaScript file using `bun build`, which includes both the TUI and headless code paths. While the TUI dependencies (React, OpenTUI) are included in the bundle, they are never loaded during headless execution — the dispatcher routes directly to the lightweight headless launcher.

```
adal (single binary)
├─ index.ts (dispatcher)
│   ├─ -q flag or piped stdin? → headless-launcher.ts (no React)
│   ├─ --ide flag? → opens browser/desktop
│   └─ default → interactive TUI (React + OpenTUI)
└─ Shared: apiBackend.ts, auth, core utilities
```

## Troubleshooting

### "Not authenticated. Run `adal` first to log in."

Your cached credentials are missing or expired. Run `adal` interactively to complete the login flow — credentials are then cached and reused for subsequent headless runs.

### Tool calls are being skipped

If the agent skips tools without `--yolo` or `--allowed-tools`, there's no TUI to approve them. Add the appropriate flag:

```bash
# Allow everything
adal -q "fix it" --yolo

# Or allow specific tools
adal -q "fix it" --allowed-tools "Read,Grep,Edit"
```

### Model switch fails

Verify the model name is valid. Use the full model identifier:

```bash
adal -q "hello" -m claude-sonnet-4-20250514
```

### Streaming stops unexpectedly

Check that your shell isn't buffering output. For real-time NDJSON, ensure line-buffered reading:

```bash
adal -q "task" -o stream-json | stdbuf -oL jq '.'
```

### Headless mode hangs

If the process doesn't exit, check:
1. **Backend startup**: The backend may take a few seconds to initialize on first run.
2. **Network**: Auth requires reaching `adal.sylph.ai` (or your `ADAL_APP_URL`).
3. **Existing backend**: Set `ADAL_BACKEND_URL` if you have a backend already running to skip startup.
