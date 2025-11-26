---
sidebar_position: 2
title: Common Issues
---

# Troubleshooting

Common issues and their solutions.

## Installation Issues

### npm install fails
```bash
# Clear npm cache
npm cache clean --force

# Try with different registry
npm install -g sylphai-adal-cli-0.1.0-beta.1.tgz --registry https://registry.npmjs.org/
```

### Permission errors on Linux/Mac
```bash
# Use sudo for global install
sudo npm install -g sylphai-adal-cli-0.1.0-beta.1.tgz

# Or change npm prefix
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
```

## Runtime Issues

### ADAL command not found
Make sure npm global bin directory is in your PATH:
```bash
# Check npm bin location
npm bin -g

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH=$(npm bin -g):$PATH
```

### Connection timeout errors
Check your internet connection and firewall settings. You may need to configure proxy settings.

### Authentication failures
Ensure your API key is valid and not expired. Re-authenticate if needed:
```bash
adal auth --reset
```

## Common Error Messages

### "Node version not supported"
Update Node.js to version 18 or newer:
- Download from [nodejs.org](https://nodejs.org/en/download/)
- Or use nvm: `nvm install 18`

### "Project not found"
Make sure you're in a valid project directory with package.json or other project files.

### "Rate limit exceeded"
Wait a few minutes before trying again, or upgrade your plan for higher limits.

## Getting Help

If you're still having issues:
1. Check [GitHub](https://github.com/SylphAI-Inc)
2. Join our [Discord community](https://discord.com/invite/ezzszrRZvT)
3. Contact support at support@sylphai.com