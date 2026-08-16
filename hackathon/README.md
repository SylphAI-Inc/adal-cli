# @skills Hackathon Presentation

Presentation page for the `@skills:` protocol and `atskills.one`.

## Public page

After the Pages workflow is merged and enabled:

<https://sylphai-inc.github.io/adal-cli/hackathon/>

## Present locally

From the repository root:

```bash
python3 -m http.server 4173
```

Open:

<http://127.0.0.1:4173/hackathon/>

## Presentation flow

1. Start with the outcome: an agent should not start recurring work from zero.
2. Explain the system diagram from right to left:
   - Team, GitHub, hub-managed, and curated skills
   - `atskills.one` for discovery and management
   - Portable `SKILL.md`
   - Reference, save, auto-load, and `/skills`
3. Walk through the two handbook journeys:
   - Use an existing skill
   - Turn a successful first pass into a reusable skill

## Source

The presentation is a self-contained HTML page:

- `hackathon/index.html`

Edit the HTML directly, then preview it with the local server before pushing changes.
