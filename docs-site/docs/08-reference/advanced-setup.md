---
sidebar_position: 3
title: Advanced Setup
---

# Advanced Setup

Configure ADAL CLI for your specific needs.

## Environment Variables

Set environment variables to customize ADAL behavior:

```bash
export ADAL_API_KEY=your_api_key_here
export ADAL_MODEL=claude-3-opus  # Choose your preferred model
export ADAL_TIMEOUT=300  # Request timeout in seconds
```

## Configuration File

Create a `.adalrc` file in your project root:

```json
{
  "model": "claude-3-opus",
  "maxTokens": 4096,
  "temperature": 0.7,
  "includePatterns": ["src/**/*"],
  "excludePatterns": ["node_modules/**", "dist/**"]
}
```

## Custom Prompts

Define project-specific instructions in `.adal/prompts.md`:

```markdown
# Project Context
This is a React application using TypeScript and Material-UI.

## Coding Standards
- Use functional components with hooks
- Follow ESLint rules strictly
- Write tests for all new features
```

## IDE Integration

### VS Code
Install the ADAL VS Code extension for seamless integration:
```bash
code --install-extension sylphai.adal-vscode
```

### Vim
Add to your `.vimrc`:
```vim
" ADAL CLI integration
nnoremap <leader>a :!adal<CR>
```

## CI/CD Integration

### GitHub Actions
```yaml
- name: Run ADAL Analysis
  run: |
    npm install -g sylphai-adal-cli-0.1.0-beta.1.tgz
    adal analyze --ci
```

### GitLab CI
```yaml
adal-check:
  script:
    - npm install -g sylphai-adal-cli-0.1.0-beta.1.tgz
    - adal lint --format gitlab
```

## Network Configuration

### Behind a Proxy
```bash
export HTTP_PROXY=http://proxy.company.com:8080
export HTTPS_PROXY=http://proxy.company.com:8080
```

### Custom API Endpoint
```bash
export ADAL_API_ENDPOINT=https://custom.api.endpoint.com
```

## Performance Optimization

### Cache Settings
```bash
# Enable aggressive caching
export ADAL_CACHE_ENABLED=true
export ADAL_CACHE_DIR=/path/to/cache
```

### Parallel Processing
```bash
# Number of parallel requests
export ADAL_CONCURRENCY=4
```

---

## Need Help?

For troubleshooting setup issues:

- **[Troubleshooting →](../07-troubleshooting/common-issues.md)** - Solutions for setup problems
- **[FAQ →](../07-troubleshooting/faq.md)** - Common questions
- 💬 **[Discord Community](https://discord.com/invite/ezzszrRZvT)** - Get help from the community
- 📧 **Email** - support@sylphai.com
