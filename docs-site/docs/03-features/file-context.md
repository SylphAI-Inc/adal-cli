---
sidebar_position: 2
title: File Context (@)
---

# File Context with @ Prefix

Use `@` to reference specific files or folders in your prompts.

## Basic Usage

```
@src/server.ts Add error handling middleware

@src/models/User.ts Add email validation

@package.json Update the build script
```

AdaL reads the file and applies changes directly—no searching needed.

---

## Syntax

| Pattern | What it does |
|---------|--------------|
| `@file.ts` | Reference single file |
| `@src/folder/` | Reference entire folder |
| `@src/*.ts` | Reference files matching pattern |
| `@file1.ts @file2.ts` | Reference multiple files |

---

## Examples

### Single File Edit

```
@src/utils/auth.ts Add password strength validation
```

### Multiple File Comparison

```
@src/services/old-auth.ts @src/services/new-auth.ts
Compare these and migrate remaining functionality
```

### Folder Analysis

```
@src/components/ Find all components using deprecated props
```

### File + Question

```
@src/server.ts What port does this server listen on?
```

---

## When to Use @

| Use @ | Don't Use @ |
|-------|-------------|
| Editing specific files | Creating new files |
| Targeting known locations | Searching for code |
| Comparing files | General questions |
| Reading file contents | Web research |

### Good Examples

```
✓ @src/api/users.ts Add pagination to the list endpoint

✓ @src/models/ Add timestamps to all models

✓ @README.md @CHANGELOG.md Update version to 2.0
```

### Skip @ (Let AdaL Search)

```
✓ Find all files using the deprecated logger API

✓ Create a new UserService with CRUD operations

✓ Where is authentication handled?
```

---

## Pro Tips

### Combine with Natural Language

```
@src/server.ts The CORS config seems wrong. 
Can you check if it allows our frontend domain?
```

### Reference Related Files Together

```
@src/models/User.ts @src/services/UserService.ts @tests/user.test.ts
Add a "lastLogin" field and update tests
```

### Folder + Specific Task

```
@src/api/ Add rate limiting to all POST endpoints
```

---

## How It Works

1. **You type:** `@src/auth.ts add validation`
2. **AdaL reads:** Full content of `src/auth.ts`
3. **AdaL understands:** File structure, imports, existing code
4. **AdaL edits:** Makes targeted changes to that file

No searching, no guessing which file you mean.

---

## Autocomplete

Type `@` and press `Tab` to autocomplete file paths:

```
@src/s<Tab>
→ @src/server.ts
→ @src/services/

@src/services/U<Tab>
→ @src/services/UserService.ts
```

---



