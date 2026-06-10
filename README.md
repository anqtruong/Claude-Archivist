# Claude Archivist

A reusable [Claude Code](https://claude.com/claude-code) configuration that turns
Claude into a disciplined **note-archivist** for knowledge vaults (Obsidian and
similar). It captures the conventions, guardrails, and git workflow needed to
reorganize a vault *safely* — moving and grouping notes without ever rewriting
the author's words.

This repo is a sandbox for developing and eventually publishing the Archivist as
a shareable Claude Code setup, with custom skills and agents to come.

> [!note]
> `CLAUDE.md` is now project-agnostic. Anything specific to a given vault lives in
> a `Vault Context.md` overlay at the vault root; a neutral worked example lives
> in `examples/`.

## What's inside

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | The archivist's project-agnostic operating instructions: first-run vault setup, the prime directive (reorganize, never rewrite), reference-only sources, capture-inbox rules, note/tag conventions, linking, folder structure, and the git workflow. |
| `Vault Context.template.md` | Blank project overlay. Copy to `Vault Context.md` at the vault root and fill in what's specific to your vault (project, reference-only files, tag menu, folder names). |
| `examples/Vault Context (example).md` | A filled-in overlay example with neutral placeholder content. |
| `.claude/settings.json` | Registers the `SessionStart` hook. |
| `.claude/hooks/session-git-status.sh` | Best-effort git/PR + vault-setup snapshot injected into context at session start (current branch, merge state, open PRs, dirty tree, and whether the Archivist structure exists yet). |
| `memory/` | Seed memories — durable, project-agnostic preferences Claude should carry across sessions. |
| `.gitignore` | Ignores per-machine `.claude/settings.local.json` and `.DS_Store`. |

### Seed memories

- `commit-message-style.md` — keep commit messages concise.
- `no-coauthored-by-in-commits.md` — never add Claude attribution to commits or PR bodies.

These are bootstrap examples of the memory format; vault-specific facts are
intentionally left out so the template starts clean.

## Using it

1. Copy `CLAUDE.md`, `.claude/`, `Vault Context.template.md`, and (optionally) the
   `memory/` seeds into the root of the vault/repo you want Claude to archive.
2. Open the folder with Claude Code. The `SessionStart` hook runs and reports
   git/PR status and whether the Archivist structure exists yet.
3. On a fresh vault, Claude offers to set it up — creating `Unorganized Notes/`,
   the MOC, `Tag Index.md`, and a `Vault Context.md` overlay for you to fill in.
4. Ask for a reorganization pass.

## Roadmap

- [x] Generalize `CLAUDE.md` into a project-agnostic archivist template (strip
      the project-specific framing into an optional overlay).
- [ ] Package the reorganization workflow as a custom **skill**.
- [ ] Add a reorganization **agent** for autonomous passes.
- [ ] Document setup for non-Obsidian knowledge bases.
