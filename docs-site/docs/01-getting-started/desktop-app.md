---
sidebar_position: 6
title: Desktop App (Preview)
description: "Install and use the AdaL Desktop app for a native AI-powered coding experience with project navigation, sessions, and review tools."
---

# Desktop App (Preview)

AdaL Desktop is the native AdaL experience for working on projects in a visual workspace. It gives you a home screen for projects and recent sessions, a chat-first coding workflow, file browsing, and a dedicated review experience for checking changes before you move forward.

:::note Preview
AdaL Desktop is currently in preview. The CLI remains the recommended stable interface, while the desktop app is the best place to try the newest native workspace experience.
:::

## Why use AdaL Desktop?

Use the desktop app when you want:

- A native GUI app instead of a terminal UI
- A project home screen with recent sessions
- A workspace designed around chat, files, and code changes
- Review Agent flow for undestanding and clustering PRs
- The same AdaL account and agent experience across CLI and Desktop

## Supported platforms

AdaL Desktop is currently available for:

| Platform | Package type |
|----------|--------------|
| macOS | `.dmg` |

## Install

Download the desktop installer from:

[https://adal.sylph.ai/download/desktop](https://adal.sylph.ai/download/desktop)

After installing, you can open AdaL Desktop in either of these ways:

- Click the **AdaL** app icon from your applications menu
- Open AdaL CLI in your project and run `/ide`

## First launch

When you open AdaL Desktop, you start on the home screen.

From there you can:

1. Pick a project folder
2. Start a new task from the chat input
3. Choose a workflow mode such as coding, research, or video
4. Continue work from recent sessions
5. Move into a focused workspace for the project

The goal is to make starting work feel closer to opening an IDE: choose a project, describe what you want, and keep the conversation, files, and changes in one place.

## Workspace experience

The desktop workspace is designed for everyday development tasks:

- Ask AdaL to explain, edit, debug, or improve code
- Browse project files without leaving the app
- Keep sessions organized by project
- Switch between active work and previous conversations
- Review generated changes visually before deciding what to do next

## Review Agent

AdaL Desktop puts review at the center of the coding workflow. The Review Agent helps you move from “AdaL changed code” to “I understand and trust these changes.”

Instead of reviewing a long list of files one by one, the Review Agent organizes changes into a guided review experience.

### Guided PR self-review

Use the Review Agent when you want to review a PR.

It helps you:

- See what files changed
- Compare before-and-after code in a visual diff
- Understand why related changes belong together
- Leave notes on specific parts of a diff
- Track what has been reviewed and what still needs attention
- Ask AdaL to revise or explain changes before you continue

### PR clusters

For larger tasks, AdaL groups related edits into **clusters**. A cluster is a set of changes that should be reviewed together, such as a UI update, an auth change, or a test update.

This makes multi-file work easier to understand because you can review by intent instead of jumping through unrelated files.

To make the cluster, open a PR branch with AdaL Desktop, trigger the review agent in the chat and ask the review agent to make a cluster for the PR.

In a review, you may see:

- Groups of related files
- A guided walkthrough of each group
- A visual sense of how parts of the change depend on each other
- Clear progress as files are confirmed or marked for follow-up

### Review notes and comments

While reading a diff, you can select code and leave review notes. This is useful for questions, follow-ups, or issues you want AdaL to address.

Review notes help you:

- Mark something as resolved or unresolved
- Keep feedback attached to the relevant code
- Collect issues before asking AdaL to revise
- Turn review feedback into GitHub PR comments when reviewing a pull request


## Authentication

AdaL Desktop uses the same AdaL account system as the CLI interface.

On first use, the app opens a browser-based sign-in flow. After you authenticate, your desktop app is connected to your AdaL account.

## Desktop vs CLI

| Interface | Best for |
|-----------|----------|
| **CLI** | Fast terminal-native coding, automation, and keyboard-first workflows |
| **Desktop** | Native project workspace, recent sessions, file browsing, and visual review |

All AdaL interfaces share the same core AdaL experience, so you can choose the interface that best fits the way you like to work.

