---
title: Input Methods
sidebar_position: 3
sidebar_label: Input
---

# How to Input Text and Images

This guide shows you different ways to provide content when using AdaL CLI.

## Quick Overview

- **Type/Paste** - Platform-specific (⌘V vs Ctrl+V)
- **@ References** - Universal (images, files, directories)
- **Drag & Drop** - Shows path, agent reads

---

## @ References (Universal)

Type `@` followed by a path to include images, files, or directories. Works on **all platforms**.

| Type | Example | Display |
|------|---------|---------|
| **Image** | `@screenshot.png` | `@screenshot.png`<br/>⎿ Read screenshot.png |
| **File** | `@config.json` | `@config.json`<br/>⎿ Read config.json (42 lines) |
| **Directory** | `@docs` | `@docs`<br/>⎿ Listed directory docs/ (4 items) |

:::tip Best for Working Directory
@ references work best for files within your current working directory. For files outside, use paste or drag & drop.
:::

---

## Text Input

### All Platforms

**Type Directly**
- Simply type your question or message
- Best for short queries and commands

**Copy & Paste**
- **Short text**: Appears exactly as pasted
- **Long text**: Shows placeholder with line count
  ```
  > [Pasted text #1 +15 lines]
    ⎿ Attached pasted content
  ```
- Full text is included as an attachment

| Platform | Shortcut |
|----------|----------|
| macOS | ⌘V |
| Linux/Windows | Ctrl+V |

---

## Image Input

### macOS (Full Support)

**Copy & Paste** ✅
- Take screenshot (⌘⇧3 or ⌘⇧4) OR copy image from Finder (⌘C)
- Paste with ⌘V
- Shows:
  ```
  > [Image #1]
    ⎿ Read /Users/.../.adal/tmp/images/paste-xxxxx.png
  ```

**Drag & Drop**
- Drag image from Finder into AdaL
- Shows file path, agent reads the image

**@ Reference**
- `@screenshot.png` → image attached

### Linux & Windows

**Copy & Paste** ⚠️
:::warning Not Yet Supported
Image paste not available. Use @ reference or drag & drop instead.
:::

**Drag & Drop** ✅
- Drag image from file manager into AdaL
- Shows file path, agent reads the image

**@ Reference** ✅
- `@screenshot.png` → image attached

---

## Combining Inputs

Mix and match in a single message:
- Type your question
- Add `@src/app.py` to reference code
- Paste an error screenshot
- Include `@docs/` for context

Example:
```
Why is this failing? @src/handler.py
> [Image #1]
  ⎿ Read error-screenshot.png
```
