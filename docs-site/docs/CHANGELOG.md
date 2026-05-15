---
sidebar_position: 99
title: Changelog
slug: /changelog
---

# Changelog

All notable changes to AdaL CLI will be documented in this file.

## [1.1.4] - 2026-05-15

- (Preview) `/ide` command now available - open your session in the browser with one keystroke
- (Preview) self-review agent feature now available in `/ide` - open your PR and the agent auto-clusters and explains huge reviews for you
- More reliable auto-updates on Windows
- Improved instruction following and tool accuracy across all models
- Improved cross-platform reliability on Windows with non-UTF-8 locales

## [1.1.3] - 2026-05-09

- Unified tool expand/collapse toggle for cleaner message display
- Faster first-query response times
- Improved token tracking accuracy for all Chat Completions providers
- Subagents run more reliably across providers

## [1.1.1] - 2026-05-05

- Improved subagent performance and token efficiency
- Fixed Anthropic multiple image input inconsistencies
- Added support for reading SVG files
- Added a native installer for Windows users
- Added Browser Use mode; press Tab to toggle among Plan, Deep Research, and Browser Use modes

## [1.0.9] - 2026-05-01

- Improved the UX of image gen with GPT and Gemini models
- Fixed the windows crash bugs reported and improved product reliability

## [1.0.8] - 2026-04-25

- Fixed image generation error and improved product reliability

## [1.0.7] - 2026-04-25

- Added GPT-5.5 model support
- First week 50%-off promotion for new models include GPT, DeepSeek, KIMI and Claude

## [1.0.6] - 2026-04-24

- Fixed known issues in new model clients(DeepSeek & KIMI)

## [1.0.5] - 2026-04-24

- Added GPT Image 2 support for image generation
- Added DeepSeek V4 Flash&Pro models
- Added KIMI 2.6 model
- Minor UX polish and bug fixes

## [1.0.4] - 2026-04-20

- Added support for Claude Opus 4.7 models
- Minor UX polish and bug fixes

## [1.0.3] - 2026-04-16

- Added Cron Agent support and interactive `/cron` management in the CLI
- Fixed ChatGPT subscription streaming issues
- Fixed Anthropic model image input handling
- Improved error message handling

## [1.0.2] - 2026-04-03

- Improved error messages display
- Improved image generation requests stability

## [1.0.1] - 2026-03-31

- Optimized the running memory of the AdaL session process
- Improved Claude model requests stability
- Added worktree info in exit UX if applicable

## [1.0.0] - 2026-03-27

- Introduced Deep Research, a dedicated mode for investigating complex tasks and delivering structured reports (Tab to toggle)
- Added Linux ARM64 support
- Fixed Linux lagging issue
- Enabled long-running agent execution when YOLO mode is toggled via /permissions
- Improved streaming error handling and auto-retry
- Added terminal notifications when AdaL needs user attention
- Improved MCP user experience with smoother authentication and stable connections
- Added a `--resume` flag for resuming previous sessions by ID
- Resolved an issue affecting skill installation
- Fixed slash-prefixed messages can't be queued mid-turn
- Fetch tool display enrichment
- Fixed an issue on WSL where pressing i for more info could fail silently
- Improved chat history display with progressive loading
- Fixed resumed-session display issues for subagents
- Simplified compression report display
- AdaL Web: Improved feature parity with AdaL CLI
- AdaL Web: a redesigned UI
- AdaL Web: added file view support
- AdaL Web: Fixed browser not auto-opening on WSL

## [0.9.9] - 2026-03-18
- Added MiniMax M2.7 and M2.7 Highspeed models
- Added YOLO mode to auto-approve all tools and bash commands (/permissions)

## [0.9.8] - 2026-03-17
- Improved Claude streaming reliability with fewer timeout errors
- Improved error messages for rate limits for clarity

## [0.9.7] - 2026-03-16
- Added GLM-5-Turbo from Z.ai
- Reduced TimeoutError for Claude Opus models to allow long responses to pass

## [0.9.6] - 2026-03-14
- Fixed MCP servers incorrectly showing as "not ready" after successful authentication

## [0.9.5] - 2026-03-11
- Improved reliability for GLM requests

## [0.9.4] - 2026-03-11
- Improved image generation reliability
- Fixed incorrect mapping of queued @file references to images
- Corrected hidden-line counts in diff view
- Resolved a plugin install issue affecting some marketplace sources
- Consolidated `adal --help` information
- Renamed `adal workspace` to `adal worktree` and simplified its usage
- Added `--model` support for headless mode to specify models
- Added a clear "Text-only" capability indicator in model selection for non-vision models
- Minor UI improvements for assistant messages

## [0.9.3] - 2026-03-07
- Terminal tab title now shows AdaL
- Bug fix in edit file path resolution

## [0.9.2] - 2026-03-06
- Improved subagent performance
- Added automatic subagent folding after completion
- Further optimized prompt caching
- Added @ autocomplete directory suggestions
- Refined /model panel UI

## [0.9.1] - 2026-03-05
- Added GPT-5.4 in ChatGPT subscription
- Optimized cache hit rate
- Optimized error self-recovery and subagent performance
- AdaL Web: aligned stream/subagent behavior with AdaL CLI

## [0.9.0] - 2026-03-05
- Added subagent support to improve AdaL's efficiency and performance
- Optimized prompt caching to make AdaL 2x cost-effective
- Added GPT-5.3 Codex and GPT-5.4 from OpenAI and set GPT-5.3 Codex as the current default model
- Added GLM-5, GLM-4.7 FlashX and 3 more models from Zai
- Upgraded image generation to Nano Banana 2 and enabled image editing
- Memory optimization improvements for smoother long sessions
- Corrected the effective input context window for all OpenAI models from 400k to 272k
- Bug fixes in Ollama local model support
- Refined /model panel metadata, pricing display, and selector UX
- Removed /auth and merged auth details into /about
- Keyboard shortcuts now respond to both lowercase and uppercase keys
- Slash autocomplete completes commands without auto-running, allowing arguments to be added before execution
- Fixed and optimized scrollbar behavior
- Added context percentage display in the footer
- Fixed inaccurate line counts in “click to expand”

## [0.8.5] - 2026-02-28
- Fixed GPT models via ChatGPT subscription returning "Unsupported parameter" errors

## [0.8.4] - 2026-02-27
- Fixed GPT models crashing during long sessions
- Improved context window utilization to enable longer conversations before compaction
- Deprecated older OpenAI models (GPT-4.1, o4-mini, standard GPT-5/5.1) and prioritized Codex variants
- Added GPT-5.2 Codex as a recommended model

## [0.8.3] - 2026-02-25
- Added image generation tool via Google Gemini's Nano Banana
- Supported using ChatGPT subscription in adal to use OpenAI models
- Added headless mode to run adal in non-interactive CLI execution (`adal -q "query"`)
- Supported select text to copy on all major platforms and terminals
- Supported copy images from screenshots
- Unified design on click to expand and collapse
- Move status notification to display on the same row as the loading indicator for a more compact UI layout

## [0.8.2] - 2026-02-21
- Faster MCP startup
- Sync MCP tools when switching models

## [0.8.1] - 2026-02-21
- Added read image tool to analyze images directly
- Improved file editing with fewer retries and more reliable edits
- Local model support via ollama (preview)

## [0.8.0] - 2026-02-19
- Improved agentic tool use and communication across all models
- New models - Google: Gemini 3.1 Pro
- New models - MiniMax: M2.5 and M2.5 Highspeed
- New models - Anthropic: Claude Sonnet 4.6
- New models — OpenAI: GPT-5.2 Codex and 9 more
- Redesigned /model dialog with provider-specific sections
- Supported click to expand and collapse for lengthy display
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
