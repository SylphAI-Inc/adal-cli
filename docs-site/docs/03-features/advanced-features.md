---
sidebar_position: 2
title: Advanced Features
---

# Advanced Features

## Multi-File Operations

Work across multiple files simultaneously:
```
Refactor user authentication to use JWT tokens across all API endpoints
```

## Code Generation

| Pattern | Example |
|---------|---------|
| Design patterns | `Implement the repository pattern for data access` |
| Architecture | `Set up clean architecture with domain/application/infrastructure layers` |
| Migrations | `Migrate class components to functional components with hooks` |

## Context Awareness

AdaL understands your project:
- Analyzes `package.json`, `requirements.txt`
- Follows existing code patterns
- Respects linting rules
- Maintains consistent style

## Code Analysis

```
Analyze performance bottlenecks in the dashboard component

Check for security vulnerabilities in authentication

Find and update deprecated dependencies
```

## Test Generation

```
Generate unit tests for userService with 90% coverage

Create failing tests for shopping cart, then implement it
```

## Documentation

```
Generate OpenAPI docs for all REST endpoints

Add JSDoc comments to all public methods
```

## Git Operations

```
Create a meaningful commit message for these changes

Set up GitHub Actions for testing and deployment
```

## Configuration

### Model Selection
```bash
/model claude-3-opus    # Complex tasks
/model claude-3-haiku   # Quick responses
```

### Custom Prompts
Create in `.adal/prompts/`:
```markdown
# testing.md
Always use Jest and React Testing Library.
Focus on user behavior over implementation.
```

### Custom Workflows
Define in `.adal/workflows.json`:
```json
{
  "workflows": {
    "feature": ["create_branch", "implement", "add_tests", "create_pr"]
  }
}
```
