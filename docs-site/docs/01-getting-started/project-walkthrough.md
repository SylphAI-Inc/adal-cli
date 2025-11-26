---
sidebar_position: 3
title: Project Walkthrough
---

# Project Walkthrough

Complete workflow from init to commit.

---

## Step 1: Initialize

```bash
cd my-express-api
adal
```

```
> /init Express.js REST API with PostgreSQL

✓ Detected: Node.js, Express, TypeScript, Prisma
✓ Created AGENTS.md
```

---

## Step 2: Research (Optional)

```
> What are best practices for JWT authentication in Express.js?

🌐 Searching...

Key findings:
- Use httpOnly cookies
- Implement refresh token rotation
- Add rate limiting
- Hash passwords with bcrypt (12+ rounds)
```

---

## Step 3: Plan

```
> Add user authentication with JWT and password hashing

📋 Plan:
1. Install bcrypt, jsonwebtoken
2. Create User model
3. Build AuthService
4. Add auth middleware
5. Create endpoints
6. Write tests

Proceed? (y/n)
```

---

## Step 4: Build

```
> Yes

[Tool: bash] npm install bcrypt jsonwebtoken
[Return]
✓ Installed

[Tool: edit] prisma/schema.prisma
+ model User { id, email, password, createdAt }
[Return]
✓ User model added

[Tool: create] src/services/AuthService.ts
[Return]
✓ AuthService created

[Tool: create] src/middleware/auth.ts
[Return]
✓ Middleware created
```

---

## Step 5: Test

```
> Run the tests

[Tool: bash] npm test
✓ 12/12 passed
```

---

## Step 6: Debug (if needed)

```
> Login test failing with "Invalid password"

[Reads AuthService.ts]
Found: bcrypt.compare() not awaited

[Tool: edit] src/services/AuthService.ts
- if (bcrypt.compare(password, user.password))
+ if (await bcrypt.compare(password, user.password))
[Return]

> Run tests again
✓ 12/12 passed
```

---

## Step 7: Search for Issues (Optional)

```
> Search for express-rate-limit production issues

🌐 Found:
- Needs trust proxy enabled for Heroku/AWS
- Requires Redis for multi-instance apps

> Fix the trust proxy issue

[Tool: edit] src/server.ts
+ app.set('trust proxy', 1);
[Return]
✓ Fixed
```
---

## Step 8: Use MCP Tools (Optional)

```
> Use GitHub MCP to search for similar auth implementations

[MCP: GitHub]
🔍 Searching sylph-ai/adal-cli issues...

Found:
#42: JWT refresh token patterns
#58: OAuth2 integration examples
#73: Rate limiting strategies

> Show me issue #42

[MCP: GitHub]
Fetching issue #42...

Key patterns:
- Sliding refresh token expiration
- Token rotation on each use
- Blacklist for revoked tokens

Apply these patterns? (y/n)
```

---

## Step 9: Report Bugs (Optional)

```
> /bug Missing documentation for trust proxy requirement

📝 Bug report created
📎 Link: https://github.com/Sylph-AI/adal-cli/issues/new

Open in browser? (y/n)
```

---

---

## Step 10: Commit

```
> Create a commit

[Tool: bash] git add -A && git commit -m "feat: add JWT auth"
[Return]
✓ Committed
```

---

## Step 11: Done

```
> /stats

Duration: 25 min | Tokens: 45K | Files: 5

> /quit
```

---

## Lifecycle Summary

| Phase | Action | Command/Prompt |
|-------|--------|----------------|
| Init | Set context | `/init [description]` |
| Research | Web search | "What are best practices for..." |
| Plan | Describe feature | "Add user auth with JWT" |
| Build | Approve edits | Press `Return` to accept |
| Test | Verify | "Run the tests" |
| Debug | Fix issues | "This test is failing..." |
| Search | Find solutions | "Search for [problem]" |
| MCP | Use external tools | "Use GitHub MCP to..." |
| Report | File bug | `/bug [description]` |
| Commit | Save work | "Create a commit" |
| Exit | End session | `/quit` or `Ctrl+C` |
## Step 10: Done

```
> /stats

Duration: 25 min | Tokens: 45K | Files: 5

> /quit
```

---

## Lifecycle Summary

| Phase | Action | Command/Prompt |
|-------|--------|----------------|
| Init | Set context | `/init [description]` |
| Research | Web search | "What are best practices for..." |
| Plan | Describe feature | "Add user auth with JWT" |
| Build | Approve edits | Press `Return` to accept |
| Test | Verify | "Run the tests" |
| Debug | Fix issues | "This test is failing..." |
| Search | Find solutions | "Search for [problem]" |
| Report | File bug | `/bug [description]` |
| Commit | Save work | "Create a commit" |
| Exit | End session | `/quit` or `Ctrl+C` |

---

## Key Commands

**Session:**
- `/init [description]` - Initialize project context
- `/stats` - View session statistics
- `/compact` - Reduce context size
- `/resume` - Resume previous session
- `/quit` - Exit session

**Actions:**
- `@file` - Reference specific files
- `[Return]` - Accept tool action
- "Run tests" - Execute test suite
- "Search for..." - Trigger web search
- `/bug [issue]` - Report bugs

---

**Next:** [Workflows & Examples →](./workflows-and-examples.md) · [MCP Integrations →](../06-integrations/mcp-support.md)
