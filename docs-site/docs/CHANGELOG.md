---
sidebar_position: 99
title: Changelog
slug: /changelog
---

# Changelog

All notable changes to AdaL CLI will be documented in this file.

## [0.8.0] - 2026-02-19
- Improved agentic tool use and communication across all models
- New models - Google: Gemini 3.1 Pro
- New models - MiniMax: M2.5 and M2.5 Highspeed
- New models - Anthropic: Claude Sonnet 4.6
- New models — OpenAI: GPT-5.2 Codex and 9 more
- Redesigned /model dialog with provider-specific sections
- Suppoprted click to expand and collapse for lengthy display
- Improved diff view with inline change highlighting
- Overlay-style floating header on the top right corner
- New theme selection with configurable terminal background
- New user query UI design
- Improved bash confirmation dialog layout
- AdaL Web: real-time git branch updates and auto-refresh file explorer on branch change
- AdaL Web: diff viewer in the sidebar for reviewing changes

## [0.7.1] - 2026-02-12
- Improved @ search by skipping autocomplete when a space follows @
- Fixed file editing issues on Windows
- Reduced hallucination and improved error self-recovery
- Bash confirmation dialog now shows agent description for better context
- AdaL Web: smart scrolling with automatic scroll-to-bottom on query submission
- AdaL Web: added AGENTS.md creation in the sidebar

## [0.7.0] - 2026-02-10
- AdaL Web (Preview): a new browser-based interface for AdaL that can access core capabilities (`adal --web`)
- Blazing-fast file search performance
- Smarter auto-retry for model provider issues
- Recommended models section in /model for quick access to top picks

## [0.6.3] - 2026-02-05
- Added Claude Opus 4.6 (1M context window)
- Always-on adaptive thinking that removes the thinking toggle
- Loading indicator UI improvements
- Model tags and display name cleanup

## [0.6.2] - 2026-02-05
- Added Claude Opus 4.6 day 1 support (/model)
- Improved error handling and retry experience
- Smoother tool cancellation experience
- Improved workspace management to enable parallel development
- Optimized UI display for input area and toggle displays

## [0.6.1] - 2026-02-02
- Simplified thinking mode from 3 modes to 2 modes (on/off)
- Better scrolling experience with automatic scroll-to-bottom on query submission
- Automatic retry logic for network errors
- Better error handling and recovery
- Minor bug fixes

## [0.6.0] - 2026-01-31
- Parallel tool calls for ~50% faster execution and lower token cost
- Lightning-fast memory compaction averaging 8s with more effective context retention
- Better error handling with faster failure on context overflow
- More accurate @ reference search navigation
- Improved agent memory management
- Improved session resume with consistent thinking content and message counts
- Skills auto-update and improved UI
- Supported using skills CLI to install skills to AdaL
- Changed default model to Claude Opus 4.5
- Clearer /init onboarding experience
- Added 'i' keyboard shortcut in dialogs to open documentation
- Supported Mermaid diagram rendering
- Fixed table border misalignment and code block highlighting in answer rendering
- Added current model name below the input box

## [0.5.4] - 2026-01-28
- Minor bug fixes for compaction and session resume

## [0.5.3] - 2026-01-27
- Faster @ reference search navigation
- Workspace management to enable parallel development
- Visual separator marker showing where compaction occurred when resuming sessions
- Ctrl+R (thought toggle) and Ctrl+C (cancel/exit) now work when dialogs are open
- Show changelog after auto update

## [0.5.2] - 2026-01-24
- Thinking mode on by default
- Better view when resuming sessions
- Removed redundant aliases for a tidier command palette
- Added spinner for bash tool execution display
- Clearer plan mode separators in message history
- Unified notification toasts for copy actions
- Theme improvements
- Other minor bug fixes

## [0.5.1] - 2026-01-15
- Improved scrolling experience across all platforms
- Smarter code display with automatic line wrapping in diffs and code blocks
- Fixed known bugs in /model and /theme selections
- Consolidated keyboard shortcuts and slash commands
- Use Ctrl+C to cancel streaming anytime
- Git-aware file operations that preserve history, better multi-line commit messages

## [0.5.0] - 2026-01-13
- New UI: more stable, no flashing, no flickering, faster performance throughout the session
- Improved input experience: cursor navigation, Shift+Enter for multi-line input, better query history navigation via up/down arrow
- New logo and header design
- Simplified /theme
- Better markdown formatting and table rendering
- Enhanced image understanding
- Improved /compact
- Enhanced /changelog with more history and link to documentation
- Fixed auto-edit UI not updating after Shift+Tab or option selection during edit confirmations

## [0.4.0] - 2026-01-07
- Supported more Linux distributions
- Added Plan Mode (Ctrl+P) for planning-first workflows
- Added google-gemini-3-flash-preview (/model)
- Removed google-gemini-flash-2.5 and gpt-4o

## [0.3.5] - 2026-01-05
- Faster query response
- Supported more general web content for websearch, including images, places, and more
- Fixed issues of fetching URL content
- Fixed the "unknown slash command" issues
- Improved bug reporting (/bug)
- Enhanced file path handling

## [0.3.4] - 2026-01-01
- Full support for skills (/skills): plugins/marketplace, personal and project skills
- Improved branch display with cleaner format showing directory and branch
- More robust auto-compact
- Faster and more token efficient manual compact (/compact)
- Added GPT-4o model support with robust output parsing
- Enhanced error recovery
- Other minor bug fixes and improvements

## [0.3.3] - 2025-12-24
- More reliable file editing
- Reduced UI flickering
- Cleaner explanation and answer display

## [0.3.2] - 2025-12-22
- Improved URL content fetch success rate

## [0.3.1] - 2025-12-22
- Faster bash command display with real-time updates
- Cleaner and more readable answer formatting
- Improved URL content extraction and processing
- Faster web search
- Better file editing experience
- Improved the UI stability
- Enhanced /help with clearer guidance
- Other minor improvements and bug fixes

## [0.3.0] - 2025-12-15
- Reduced token usage by ~20%
- Full history HTML view (/stats): export and view complete conversation history in HTML format
- Unified input behavior: consistent copy/paste experience across texts, files, and images
- Improved session resume (/resume): better state preservation and recovery
- Faster response time: optimized agent execution
- Integrated Claude Opus 4.5 into model pool (/model)
- Other minor bug fixes

## [0.2.3] - 2025-12-04
- Fixed known streaming bugs
- Improved user experience

