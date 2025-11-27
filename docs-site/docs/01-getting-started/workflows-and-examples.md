---
sidebar_position: 3
title: Workflows & Examples
---

# Workflows & Examples

Practical patterns for everyday development.

---

## Explore Codebase

```
Analyze this codebase and give me an architecture overview

Where is the authentication logic implemented?

@src/auth/service.ts Explain how this works
```

---

## Debug Issues

```
I'm getting: TypeError: Cannot read property 'map' of undefined at UserList.tsx:42
```

AdaL analyzes, proposes fixes, implements with tests.

```
Run the tests to verify the fix
```

---

## Refactor Code

**Basic:**
```
Refactor this function to be more readable

Convert callbacks to async/await

Apply the repository pattern to data access
```

**Large-scale (use safety pattern):**
```
Create a git branch called refactor/auth-service

Now refactor the auth system step by step, running tests after each change
```

---

## Web Search

```
What are best practices for JWT authentication in Express.js?

Search for common React performance issues

What's the latest version of Next.js?

Research PostgreSQL indexing best practices
```

---

## Work with Tests

```
Generate unit tests for @src/services/userService.ts

Create integration tests for /api/auth endpoints

Write failing tests for shopping cart, then implement it
```

---

## Generate Documentation

```
Generate OpenAPI docs for all REST endpoints

Add JSDoc comments to @src/services/userService.ts

Update README with the new authentication setup
```

---

## Create PRs

```
Show me what changed in this branch

Create a pull request description for these changes

Create a meaningful commit message and push to origin
```

---

## Reference Files with @

```
@src/server.ts Add error handling middleware

@src/auth/service.ts @src/auth/middleware.ts Ensure consistent error handling

@src/services/ Add logging to all service methods
```

**Use @** when targeting specific files. **Skip @** when creating new files or searching.

---

## Thinking Mode

Press `Tab` or use keywords:
```
Think deeply about how to optimize this algorithm

Reason carefully about security implications

Analyze thoroughly the performance bottlenecks
```

---

## Session Management

```
/compact    # Reduce context
/resume     # Resume previous session
/quit       # Exit (or Ctrl+C)
```

---

## Parallel Sessions (Git Worktrees)

```bash
# Terminal 1
git worktree add ../project-feature-a feature/user-auth
cd ../project-feature-a && adal

# Terminal 2
git worktree add ../project-feature-b feature/payments
cd ../project-feature-b && adal
```

---

## Unix-Style Usage

```bash
# Pipe input
git diff | adal --question "Explain these changes"
npm test 2>&1 | adal --question "Why are tests failing?"

# Pipe output
adal --question "Create a user schema" > schema.prisma
```

---


## Best Practices

**Prompts:**
- ✅ "Create a React component for user profiles with avatar, name, email, and bio fields"
- ❌ "Make a user component"

**Security:**
- No API keys in prompts
- Use environment variables
- Review generated code

---

**Next:** [Quickstart →](./your-first-session.md)

**Help:** [Discord](https://discord.com/invite/ezzszrRZvT) · [GitHub](https://github.com/SylphAI-Inc)
