---
sidebar_position: 11
title: "Headless Mode"
description: "Run AdaL programmatically without the interactive UI — pipe queries, get structured output, and integrate AdaL into scripts, CI/CD pipelines, and automation workflows."
---

# Headless Mode

AdaL's headless mode lets you run queries programmatically without the interactive terminal UI. Pass a prompt, get a result — as plain text, structured JSON, or a real-time NDJSON stream. It uses the exact same agent, tools, and capabilities as the interactive CLI.

Use headless mode to integrate AdaL into shell scripts, CI/CD pipelines, editor extensions, or any automation workflow.

## Prerequisites

Headless mode requires authentication. Run `adal` interactively once — your credentials are cached and reused automatically by headless mode.

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
{"type":"tool_call","name":"search","args":{"pattern":"TODO","path":"src/"}}
{"type":"tool_result","name":"search","status":"success"}
{"type":"tool_call","name":"edit","args":{"file":"src/app.ts"}}
{"type":"tool_result","name":"edit","status":"success"}
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

In interactive mode, AdaL pauses and asks you to confirm before running tools that modify files or execute commands. In headless mode there's no UI for approval dialogs, so you control permissions upfront.

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
# Only allow read operations and search
adal -q "analyze the codebase" --allowed-tools "Read,Search"

# Allow reads, edits, but not shell commands
adal -q "fix the typos" --allowed-tools "Read,Search,Edit"
```

#### Tool Groups

| Group | Description |
|-------|-------------|
| `Read` | Read files and images |
| `Search` | Search within files and the web |
| `Edit` | Create, modify, and delete files |
| `Bash` | Execute shell commands |
| `Image` | Generate images |

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

Beyond `-q` queries, AdaL exposes subcommands that work entirely in headless mode without launching the interactive UI.

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

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success — query completed, answer returned |
| `1` | Failure — auth error, model error, or agent error |

## Agent Integration Examples

### SRE: Automated Incident Response

```bash
#!/bin/bash
investigate_incident() {
    local description="$1"
    local severity="${2:-medium}"

    adal -q "Incident: $description (Severity: $severity). \
      Diagnose the issue, assess impact, and provide immediate action items." \
      --yolo -o json
}

# Usage
investigate_incident "Payment API returning 500 errors" "high"
```

### GitHub Actions: Automated Code Review

```yaml
- name: Run AdaL code review
  run: |
    adal -q "Review the changes in this PR for bugs and security issues. \
      Focus on error handling and input validation." \
      --allowed-tools "Read,Search" \
      --yolo \
      -o json > review.json
```

### CI/CD: Auto-fix Lint Errors

```bash
#!/bin/bash
result=$(adal -q "fix all ESLint errors in src/" --yolo -o json)
if echo "$result" | jq -e '.success' > /dev/null; then
  git add -A && git commit -m "fix: auto-fix lint errors"
fi
```

### Multi-Turn: Guided Refactoring

```bash
# Start the conversation
session_id=$(adal -q "Analyze the auth module for tech debt" -o json | jq -r '.session_id')

# Follow up with context from the first turn
adal -q "Now refactor the worst offender you found" -r "$session_id" --yolo
adal -q "Add tests for the refactored code" -r "$session_id" --yolo
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

### Pipe: Analyze Logs and Diffs

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

## Best Practices

- **Use JSON output** for programmatic parsing:
  ```bash
  result=$(adal -q "generate code" -o json)
  answer=$(echo "$result" | jq -r '.answer')
  ```

- **Handle errors gracefully** — check exit codes and parse failure responses:
  ```bash
  if ! result=$(adal -q "$prompt" -o json 2>error.log); then
      echo "Error occurred:" >&2
      cat error.log >&2
      exit 1
  fi
  ```

- **Add timeouts** for long-running operations:
  ```bash
  timeout 300 adal -q "$complex_prompt" --yolo || echo "Timed out after 5 minutes"
  ```

- **Use `--allowed-tools`** instead of `--yolo` when possible — grant only the permissions the task needs.

- **Use worktrees** for parallel tasks to avoid file conflicts between concurrent agents.

- **Respect rate limits** when making multiple requests — add delays between calls in batch scripts.

## Troubleshooting

### "Not authenticated"

Your cached credentials are missing or expired. Run `adal` interactively to complete the login flow — credentials are then cached and reused for subsequent headless runs.

### Tool calls are being skipped

If the agent skips tools without `--yolo` or `--allowed-tools`, there's no UI to approve them. Add the appropriate flag:

```bash
# Allow everything
adal -q "fix it" --yolo

# Or allow specific tools
adal -q "fix it" --allowed-tools "Read,Search,Edit"
```

### Model override not working

Verify the model name is valid. Use the full model identifier:

```bash
adal -q "hello" -m claude-sonnet-4-20250514
```

### Streaming stops unexpectedly

Check that your shell isn't buffering output. For real-time NDJSON, ensure line-buffered reading:

```bash
adal -q "task" -o stream-json | stdbuf -oL jq '.'
```


