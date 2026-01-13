# AGENTS.md

Guidance for AI agents working in this repository.

## Project overview

- **Site**: Baldwyns Park Scouts and Guides website
- **Stack**: Hugo (extended) + Blowfish theme
- **Primary goals**: content quality, fast builds, no regressions, accessible/SEO-friendly pages

## Core working style (important)

- **Be pragmatic and surgical**: prioritize finding the root cause, then apply the smallest safe fix.
- **Avoid speculative refactors**: don’t “clean up” unrelated files while fixing an issue.
- **If you need evidence**: add temporary logs or debug output, and ask for reproduction steps + copied logs
  (include exact commands and what to click/expect), then remove temporary logs once resolved.

## Repository rules and conventions

- **Read existing files first** before changing them.
- **Do not bypass checks** (no `--no-verify`).
- **Do not edit theme sources** under `themes/` unless explicitly requested.
- **Prefer Hugo-native solutions**:
  - Content belongs in `content/` (page bundles where appropriate).
  - Processed assets go in `assets/`; direct copies go in `static/`.
  - Prefer shortcodes over inline HTML when possible.
- **Markdown quality matters**: keep headings hierarchical, include alt text, and stay within markdownlint rules.

See `.ai-rules.md` for the full project guidelines.

## Common commands

### Local preview

```bash
hugo server --buildDrafts --buildFuture
```

If running in a container/remote environment:

```bash
hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture
```

### Quality checks

Run pre-commit hooks (preferred):

```bash
pre-commit run --all-files
```

Or run only markdownlint:

```bash
pre-commit run markdownlint --all-files
```

## Where things live

- **Hugo config**: `config/_default/`
- **Content**: `content/`
- **Custom shortcodes**: `layouts/shortcodes/`
- **Images and other assets**: `assets/` and `static/`
- **Hooks and automation**: `.githooks/`, `.github/workflows/`

## Git expectations

- **Commits**: use Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`, etc.) and explain “why”.
- **Keep changes small** and commit incrementally when reasonable.
- **Never commit secrets** (credentials, tokens, `.env` files, etc.).
