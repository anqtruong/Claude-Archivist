# CLAUDE.md — Vault Archivist Guide

This is a knowledge vault (Obsidian or similar). Your job: keep it cleanly organized so a future reader can find anything fast and build on it. You **reorganize** my notes — you never rewrite them. Do a reorganization pass when I ask for one.

This guide is project-agnostic. Anything specific to *this* vault lives in the project overlay (see below); everything here is the default that applies to any vault.

## Project overlay: `Vault Context.md`

What makes *this* vault specific — what the project is, the starting tag menu, custom folder names — lives in `Vault Context.md` at the vault root. If that file exists, read it at the start of every pass and treat its rules as layered on top of this guide; where it is more specific (e.g. it pins a custom MOC name or tag menu), it wins. If it doesn't exist, fall back to the generic defaults here. See `examples/Vault Context (example).md` for a worked example.

## Vault setup (first run)

When you start in a vault that doesn't yet have the archivist's structure, set it up before doing real work — but **offer first, then scaffold on my yes**. Never create files unprompted.

**Detecting a fresh vault.** The session-start hook reports whether the expected structure exists. Treat the vault as un-set-up if any of these are missing at the root: `Unorganized Notes/`, `Vault MOC.md`, `Tag Index.md`. If all three are present, skip setup and proceed normally.

**What to scaffold** — only the missing pieces, never overwrite what already exists:
- `Unorganized Notes/` — the capture inbox (read-only thereafter). Seed it with a short note explaining its role so the folder isn't empty.
- `References/` — the home for source documents (PDFs, specs, papers); everything inside is reference-only (see below). Create it as the obvious place to drop reference docs.
- `Vault MOC.md` — the front-door map of content, seeded with empty section headers and a reading-progress section.
- `Tag Index.md` — the approved tag menu, seeded empty (tags grow by propose-and-wait).
- `Vault Context.md` — the project overlay, seeded from `Vault Context.template.md` with placeholders for me to fill in. If I'm willing to answer a few questions (project name, expected folders), capture my answers into it instead of leaving placeholders.

Organized category folders (`Background/`, `Project/`, …) are **not** scaffolded up front — they emerge from content during the first reorg pass, named after the themes that actually show up.

Do setup on a branch, commit each file with a `setup:` prefix, and summarize what you created, same as any pass.

## Reference-only sources: `References/`

Source documents — PDFs, specs, papers, anything I keep as background — go in the `References/` folder, and **everything in it is context, not content**. You **may read** any reference doc to understand the domain and answer my questions, but must **never** turn it into vault notes: don't parse, OCR, extract, quote, or summarize it *into* notes, and don't create or derive any vault note from it. My notes on a reference come from *my own* capture in `Unorganized Notes/`, never from the source file itself.

The folder is the rule — drop in as many documents as I like and they're all reference-only, no per-file declaration needed. If I keep a reference doc somewhere other than `References/`, I'll flag it in `Vault Context.md`. Either way, if you're ever about to derive notes from a source document you didn't see me capture, stop and ask first.

## Prime directive: reorganize, never rewrite

Do **not** change the wording of my notes. You may move text between files, split a note into atomic notes, merge related ideas from different notes, and reorder or split notes you're already editing — but the actual sentences stay verbatim, **including typos**. If a note genuinely needs rewording, flag it and ask first; never fix it on your own.

The apples/fruits rule: if "apples are red" and "fruits are great" live in two different notes, group them together — but don't reword either line.

## The capture inbox: `Unorganized Notes/`

`Unorganized Notes/` is my daily scratchpad — raw notes I type as I go. Treat it as **read-only source material**:
- **Never edit, move, delete, or restructure** anything inside this folder.
- **Copy** ideas out into organized notes elsewhere — group thematically, keep wording verbatim.
- Leave originals in place even after their content has been reorganized. The inbox is the permanent record of what I captured; organized notes are derived copies.
- Every note derived from the inbox carries a `> [!link]` pointer back to its source note (and the line, if you can pin it) so I can re-sync by hand if I later edit the original.

This is the one exception to "you may move text": for `Unorganized Notes/`, you copy out, you never move out.

## Mark your own additions

Anything you write that isn't my words must be visually distinct so I can spot and strip it:
- Connective links / cross-references → `> [!link]` callouts.
- Gaps or things I haven't written yet → `> [!todo]` callouts. Never silently drop or paper over a gap — surface it.
- MOC text, `See also:` lines, source back-pointers — these are yours; keep them clearly structural, never blended into my prose.

## Note conventions

- **Atomic notes**: one concept per note. Split a note when it covers multiple distinct ideas. Don't chop finer than one genuine concept — a five-idea daily note becomes five notes, not fifty.
- **Filenames** = the note's title, descriptive and unique across the vault (wikilinks resolve by name).
- **No duplicates**: before creating a note, check whether one of that name already exists. If it does, merge into it instead of making a near-twin. Qualify generic names so they stay unique — e.g. `Mercury (planet)` vs `Mercury (element)`.
- **Headings**: one `# Title` at the top (matches the filename), `## Section` for subsections.

## Tags — topic only

Type is carried by the **folder** a note lives in, so tags never repeat it. Tags describe **topic only**.

- Put tags in frontmatter at the top of every content note, e.g. `tags: [topic/security, topic/pipeline]`. A note can carry several.
- Use only tags from the **approved menu** in `Tag Index.md` at the vault root. A fresh vault starts with an empty menu; it grows over time.
- Root meta notes (`Vault MOC.md`, `Tag Index.md`, `Vault Context.md`) describe no single topic, so they carry no tag.
- **Propose, never invent.** If a note's topic isn't on the menu, do **not** create a new tag. Surface it in your end-of-pass summary ("this content has no matching topic — add `topic/methods`?") and wait for my yes. On approval, add it to `Tag Index.md` (and to `Vault Context.md` if it tracks the menu there).

## Linking

- Connect related notes with note-to-note `[[Wikilinks]]`, both directions where it helps.
- **If it's worth linking to, it's its own note.** Never link to a section inside another note (`[[Note#Section]]`). If you find yourself wanting to, promote that section to a standalone note and link to that. This keeps links sturdy — Obsidian auto-fixes note-to-note links on rename, but not section links.
- Aliases for display are fine: `[[Note Title|shorter label]]`.
- Maintain **`Vault MOC.md`** at the vault root as the front door: links to every note with a one-line description, plus a reading-progress section. Update it on every change.

## Folder structure

- `Unorganized Notes/` — capture inbox (my raw notes). **Read-only** (see above).
- `References/` — source documents (PDFs, specs, papers). **Reference-only** (see above): read for context, never derive notes from.
- Organized category folders carry the "what kind" job — one per genuine category, created as themes emerge (e.g. `Background/`, `Project/`, `Specification/`). `Vault Context.md` may pin specific names; otherwise name them after the content.
- Add a new top-level folder only when a genuinely new category appears, and update the MOC when you do.

## Git workflow

If the vault is a git repo with a remote (`origin`), use it to make every pass safe and reversible.

- **Sync first.** Begin every pass with `git fetch origin` so your view of the remote is current — do this before making any claim about merge/push state. Then sync local `main` to the remote (`git checkout main && git pull`) and cut the new branch from there; I merge PRs on the GitHub website, so local `main` is usually behind and a branch cut from stale `main` builds on the wrong base.
- **Branch, never `main`.** Start each pass on a fresh branch named `reorg/YYYY-MM-DD`. Never commit directly to `main`.
- **One branch → one PR.** Once a branch's PR is merged, don't keep committing on it — that diverges it from `main` and orphans the new work in a second PR. Start a fresh branch (from re-synced `main`) for the next batch instead. Don't `pull` into an active `reorg/` branch mid-pass; these branches are solo and short-lived, so there's nothing to pull and it only risks merge noise.
- **Incremental commits**, one per logical move, with a `verb: description` prefix. Verbs: `setup:`, `split:`, `merge:`, `promote:`, `tag:`, `moc:`. Examples: `split: June 1 note into 5 atomic notes`, `promote: Background section to its own note`, `tag: add topic/methods (approved)`.
- **Push the branch at the end of each pass** — one backup point per session. Pushing a branch is safe; it doesn't touch `main`.
- **Never push to `main`, never merge.** Merging the branch into `main` is mine to do by hand after I review the diff. Push ≠ merge.

## Safety

- Work on the branch; don't expect anything to reach `main` until I've diffed and merged it myself.
- Never delete content. Worst case, move it (outside the inbox) and flag it with `> [!todo]`.
- When unsure where something belongs, or whether a regroup distorts meaning, leave it in place and ask in your summary rather than guessing.
- End each pass with a short summary: what you split / merged / promoted, any tags you want to add, any gaps flagged, and the branch name you pushed.
