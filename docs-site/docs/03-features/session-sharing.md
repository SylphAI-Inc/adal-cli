---
sidebar_position: 8
title: Session Sharing
description: "Export, share, and import AdaL coding sessions. Share context with teammates, hand off work across devices, and build on each other's conversations."
---

# Session Sharing

Export conversations, share them with teammates, and import sessions to continue where someone else left off.

:::info Proposed Feature
This is a proposed feature for AdaL CLI. If you'd like to see this implemented, upvote or comment on the [GitHub issue](https://github.com/SylphAI-Inc/adal-cli/issues).
:::

## Why Share Sessions?

| Use Case | Problem | Solution |
|----------|---------|----------|
| **Team handoffs** | "I debugged this for an hour, now you need to continue" | Export your session and hand it off |
| **Cross-device** | Started on your laptop, need to finish on desktop | Export → transfer → import |
| **Code reviews** | "How did the AI arrive at this solution?" | Share the full reasoning chain |
| **Knowledge base** | Solved a tricky problem? Others can learn from it | Archive sessions as team reference |
| **Bug reports** | Reproducing an issue needs full context | Share the exact session that triggered it |

## Proposed Commands

### Export a Session

```bash
adal session export [session-id] [options]
```

| Flag | Description | Default |
|------|-------------|---------|
| `--format` | Output format: `md`, `json`, `html` | `md` |
| `--output` | Output file path | `./adal-session-<id>.<ext>` |
| `--redact` | Strip API keys, file paths, secrets | `true` |
| `--include-tools` | Include tool calls and outputs | `true` |
| `--include-thinking` | Include model thinking/reasoning | `false` |
| `--compact` | Omit system prompts and metadata | `false` |

**Examples:**

```bash
# Export current session as markdown
adal session export

# Export a specific session as JSON
adal session export abc123 --format json

# Export without tool call details (cleaner for sharing)
adal session export --include-tools false

# Export with full reasoning chain
adal session export --include-thinking --format html
```

### Share a Session

```bash
adal session share [session-id] [options]
```

| Flag | Description | Default |
|------|-------------|---------|
| `--expires` | Link expiration | `7d` |
| `--access` | `read-only` or `forkable` | `read-only` |
| `--gist` | Upload as GitHub Gist | `false` |

**Examples:**

```bash
# Share via a temporary link
adal session share
# → https://share.sylph.ai/s/x7k9m2 (expires in 7 days)

# Share as a GitHub Gist
adal session share --gist
# → https://gist.github.com/user/abc123

# Allow others to fork and continue the session
adal session share --access forkable
```

### Import a Session

```bash
adal session import <source> [options]
```

| Flag | Description | Default |
|------|-------------|---------|
| `--mode` | `continue` (append) or `reference` (read-only context) | `reference` |
| `--merge-memory` | Merge the imported session's learned context | `false` |

**Examples:**

```bash
# Import from a file
adal session import ./adal-session-abc123.md

# Import from a shared link
adal session import https://share.sylph.ai/s/x7k9m2

# Import and continue the conversation
adal session import ./handoff.json --mode continue

# Import as read-only context for a new session
adal session import ./teammate-debug.md --mode reference
```

## Export Formats

### Markdown (default)

Human-readable, works everywhere. Ideal for documentation and code reviews.

````markdown
# AdaL Session Export
- **Session ID:** abc123
- **Date:** 2026-03-05
- **Model:** Claude Sonnet 4.6
- **Messages:** 24
- **Duration:** 45 minutes
- **Project:** /Users/dev/myapp

---

## User
Fix the authentication timeout in `src/auth/login.ts`

## AdaL
I'll investigate the authentication timeout issue...

### Tool: Read File
`src/auth/login.ts`

### Tool: Edit File
```diff
- const TIMEOUT = 5000;
+ const TIMEOUT = 30000;
```

The timeout was set to 5 seconds...

---

## User
Now add retry logic

## AdaL
...
````

### JSON

Machine-readable, preserves all metadata. Ideal for programmatic use and re-import.

```json
{
  "version": "1.0",
  "session_id": "abc123",
  "exported_at": "2026-03-05T14:30:00Z",
  "metadata": {
    "model": "claude-sonnet-4-6",
    "project": "/Users/dev/myapp",
    "message_count": 24,
    "token_usage": { "input": 45000, "output": 12000 },
    "duration_seconds": 2700
  },
  "messages": [
    {
      "role": "user",
      "content": "Fix the authentication timeout",
      "timestamp": "2026-03-05T14:00:00Z"
    },
    {
      "role": "assistant",
      "content": "I'll investigate...",
      "tool_calls": [
        {
          "tool": "read_file",
          "input": { "path": "src/auth/login.ts" },
          "output": "..."
        }
      ],
      "timestamp": "2026-03-05T14:00:05Z"
    }
  ]
}
```

### HTML

Rich, styled view for the browser. Uses the same format as the `/stats` history view but is portable as a standalone file.

## Privacy & Redaction

Session exports automatically redact sensitive content before sharing:

| Content | Action | Example |
|---------|--------|---------|
| API keys & tokens | Replaced with `[REDACTED]` | `ghp_xxxx` → `[REDACTED]` |
| Absolute file paths | Shortened to relative | `/Users/john/app/src` → `./src` |
| Environment variables | Values masked | `DB_PASS=secret` → `DB_PASS=[REDACTED]` |
| `.env` file contents | Fully masked | Entire content replaced |
| IP addresses & URLs | Optionally masked | `--redact-urls` flag |

**Disable redaction** (for personal exports only):

```bash
adal session export --redact false
```

:::caution
Always review exported sessions before sharing externally. Automated redaction catches common patterns but cannot guarantee complete removal of sensitive data.
:::

## Workflow Examples

### Team Handoff

Developer A hits a wall and hands off to Developer B:

```bash
# Developer A: export with full context
adal session export --format json --output handoff.json

# Share via your team's preferred method
# Slack, email, shared drive, git...

# Developer B: import and continue
adal session import ./handoff.json --mode continue
> Resuming session from Developer A (24 messages loaded)
> Last context: fixing auth timeout in src/auth/login.ts
```

### Cross-Device Resume

Started debugging on your laptop, need to finish on your desktop:

```bash
# On laptop
adal session share --expires 1d
# → https://share.sylph.ai/s/x7k9m2

# On desktop
adal session import https://share.sylph.ai/s/x7k9m2 --mode continue
```

### Building a Team Knowledge Base

Archive solved problems so the team can reference them:

```bash
# Export the session that solved a tricky bug
adal session export --format md --output docs/solved/auth-timeout-fix.md

# Future sessions can reference it
adal session import docs/solved/auth-timeout-fix.md --mode reference
> How did we fix the auth timeout last time? ^
```

### Slash Command Integration

Session sharing integrates with existing slash commands:

```
/stats           → View current session, see export options
/resume          → Browse sessions, export any of them
/share           → Quick share current session (shortcut for `adal session share`)
```

## Data Format Specification

### Session File Structure

Exported sessions follow a standard schema that any tool can parse:

```
adal-session-<id>/
├── session.json          # Metadata and messages
├── context/              # Referenced files (snapshots)
│   ├── src/auth/login.ts
│   └── package.json
└── README.md             # Human-readable summary
```

The `context/` directory includes **snapshots** of files that were read or edited during the session, so the imported session has full context even in a different repository.

## Implementation Notes

This feature builds on AdaL's existing session infrastructure:

- **`/stats`** already tracks session ID, token usage, and message counts
- **`/resume`** already serializes/deserializes session state
- **HTML history view** already generates styled conversation exports
- Session metadata is already persisted for resume functionality

The proposed commands extend these capabilities with portable export formats, privacy controls, and import/merge logic.

**Related:** [Manage & Resume Sessions](./manage-conversations.md) · [Slash Commands](./slash-commands.md) · [Persistent Memory](./persistent-memory.md)
