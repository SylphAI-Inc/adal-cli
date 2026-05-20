---
sidebar_position: 5
title: AdaL Web (Legacy)
description: "AdaL Web is the legacy browser interface. Use /ide from AdaL CLI to open Desktop when installed, or Web as a fallback."
---

# AdaL Web (Legacy)

AdaL Web is the legacy browser-based interface for AdaL. New users should move to **AdaL Desktop** for the best visual workspace, project navigation, and review experience.

:::tip Use `/ide`
From AdaL CLI, use `/ide` to open the visual AdaL workspace. If AdaL Desktop is installed, `/ide` opens the Desktop app. If Desktop is not installed, AdaL opens the Web interface in your browser as a fallback.
:::

## Recommended path

For the best experience:

1. Install **[AdaL Desktop](./desktop-app.md)**
2. Open AdaL CLI in your project
3. Run:

```text
/ide
```

This gives you the Desktop workspace when available, while still keeping Web available as the legacy browser fallback.

## When Web opens

AdaL Web opens when you use `/ide` and AdaL Desktop is not installed or not available on your machine.

The Web interface runs in your default browser and keeps the similar AdaL Desktop workflow but not full support.

## Move to Desktop

AdaL Web remains available for compatibility, but Desktop is the recommended visual interface going forward.

Desktop gives you a more native experience for:

- Project selection
- Recent sessions
- File browsing
- Visual review of code changes
- Focused project work outside the terminal

See **[Desktop App (Preview)](./desktop-app.md)** to install and use the new Desktop experience.
