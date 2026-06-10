# Claude Archivist

A reusable [Claude Code](https://claude.com/claude-code) configuration that turns
Claude into a disciplined **note-archivist** for knowledge vaults (Obsidian and
similar). It captures the conventions, guardrails, and git workflow needed to
reorganize a vault *safely* — moving and grouping notes without ever rewriting
the author's words.

This repo is a sandbox for developing and eventually publishing the Archivist as
a shareable Claude Code setup, with custom skills and agents to come.

> [!note]
> The configuration here was copied verbatim from a working research vault, so
> the wording in `CLAUDE.md` is still tailored to that vault (the "SCADA
> Compiler" project). Generalizing it into a project-agnostic template is the
> next step — see *Roadmap*.

## What's inside

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | The archivist's operating instructions: the prime directive (reorganize, never rewrite), capture-inbox rules, note/tag conventions, linking, folder structure, and the git workflow. |
| `.claude/settings.json` | Registers the `SessionStart` hook. |
| `.claude/hooks/session-git-status.sh` | Best-effort git/PR status snapshot injected into context at session start (current branch, merge state, open PRs, dirty tree). |
| `memory/` | Seed memories — durable, project-agnostic preferences Claude should carry across sessions. |
| `.gitignore` | Ignores per-machine `.claude/settings.local.json` and `.DS_Store`. |

### Seed memories

- `commit-message-style.md` — keep commit messages concise.
- `no-coauthored-by-in-commits.md` — never add Claude attribution to commits or PR bodies.

These are bootstrap examples of the memory format; vault-specific facts are
intentionally left out so the template starts clean.

## Using it

1. Copy `CLAUDE.md`, `.claude/`, and (optionally) the `memory/` seeds into the
   root of the vault/repo you want Claude to archive.
2. Open the folder with Claude Code. The `SessionStart` hook runs and reports
   git/PR status.
3. Ask for a reorganization pass.

## Roadmap

- [ ] Generalize `CLAUDE.md` into a project-agnostic archivist template (strip
      the SCADA-specific framing into an optional overlay).
- [ ] Package the reorganization workflow as a custom **skill**.
- [ ] Add a reorganization **agent** for autonomous passes.
- [ ] Document setup for non-Obsidian knowledge bases.
