---
sidebar_position: 6.5
title: Browser Use
description: "Let AdaL use a real browser to automate your web workflow."
---

# Browser Use

Browser Use lets AdaL work with a real browser while you stay in the terminal. It is useful when a task needs browser interaction with visual context, page interaction, or live web app debugging.

Use it for things like:

- Automating your web workflow
- Testing and Debugging a website
- Reaching out someone in social media
- Searching for information in the web
- Basically everything you do with the web browser


## Quick Start

We expect **chrome browser** to be installed in your computer.

```bash
adal
```

Press `Tab` until you see **Browser Use** in the footer. 

The AdaL will open a dedicated Chrome browser window, then you can ask AdaL what to do.

## How the Browser Opens

When you enable Browser Use with `Tab`, AdaL opens a dedicated Chrome window for its own use, so your everyday browser stays untouched. Switching to another mode closes that window.

If the dedicated window is already open, other AdaL sessions share it instead of opening a new one.


## Safety Notes

Browser Use can interact with real websites and real accounts, so use it thoughtfully.

- Use with caution. AdaL performs most browser actions automatically without asking for confirmation.
- Prefer test accounts and staging environments.
- Avoid entering passwords, payment details, or private information unless you explicitly intend to.
- If a page shows a browser dialog or gets stuck, you may need to manually dismiss it.
- You are responsible for how Browser Use is used. Make sure your use complies with the terms of service of any website you visit and with all applicable laws. AdaL is provided as-is, without warranty of any kind, and AdaL is not liable for any actions taken through Browser Use.

