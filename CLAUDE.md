# CLAUDE.md — Vault Reorganization Guide

This is a research vault for the **SCADA Compiler** project (TURC, advised by Dr. Hawrylak). It holds reading notes on Nivethan's 2016 dissertation and a development log for an OCR → LLM → human-review → PDL pipeline. Your job: keep it cleanly organized so a future researcher can find anything fast and build on it. Do a reorganization pass when I ask for one.

## Never parse: `Nivethan's Dissertation.pdf`

`Nivethan's Dissertation.pdf` (at the vault root) is **reference-only context**. You **may read it** to understand the compiler and answer my questions as I research — that's what it's there for. What you must **never** do is turn it into vault content: don't parse, OCR, extract, quote, or summarize it *into notes*, and don't create or derive any vault note from it. Read it for your own understanding; never reorganize it into the vault. My reading notes on the dissertation come from *my* notes in `Unorganized Notes/`, never from this file. If a future PDF or document should be treated the same way, I'll tell you.

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

- **Atomic notes**: one concept per note. Split a note when it covers multiple distinct ideas. Target depth ≈ the test run, where a five-idea daily note became five notes. Don't chop finer than one genuine concept.
- **Filenames** = the note's title, descriptive and unique across the vault (wikilinks resolve by name).
- **No duplicates**: before creating a note, check whether one of that name already exists. If it does, merge into it instead of making a near-twin. Qualify generic names so they stay unique — e.g. `Rules (PDL)` vs `Rules (operational)`.
- **Headings**: one `# Title` at the top (matches the filename), `## Section` for subsections.

## Tags — topic only

Type is carried by the **folder** a note lives in, so tags never repeat it. Tags describe **topic only**.

- Put tags in frontmatter at the top of every content note, e.g. `tags: [topic/scada, topic/security]`. A note can carry several.
- Use only tags from the **approved menu** below. The same menu lives in `Tag Index.md` at the vault root — keep the two in sync.
- Root meta notes (`SCADA Compiler MOC.md`, `Tag Index.md`) describe no single topic, so they carry no tag.
- **Propose, never invent.** If a note's topic isn't on the menu, do **not** create a new tag. Surface it in your end-of-pass summary ("this content has no matching topic — add `topic/ocr`?") and wait for my yes. On approval, add it to both this file and `Tag Index.md`.

**Approved starter menu:**
- `topic/scada`
- `topic/security`
- `topic/ids`
- `topic/firewall`
- `topic/pdl`
- `topic/pipeline`
- `topic/ocr`
- `topic/llm`
- `topic/prompt-eng`

This is a starting set, not a cap — it grows over time, but only by the propose-and-wait rule above.

## Linking

- Connect related notes with note-to-note `[[Wikilinks]]`, both directions where it helps.
- **If it's worth linking to, it's its own note.** Never link to a section inside another note (`[[Note#Section]]`). If you find yourself wanting to, promote that section to a standalone note and link to that. This keeps links sturdy — Obsidian auto-fixes note-to-note links on rename, but not section links.
- Aliases for display are fine: `[[Note Title|shorter label]]`.
- Maintain **`SCADA Compiler MOC.md`** at the vault root as the front door: links to every note with a one-line description, plus a reading-progress section. Update it on every change.

## Folder structure

- `Unorganized Notes/` — daily capture inbox. **Read-only** (see above).
- `Reference - SCADA Security/` — domain/background concepts from the dissertation.
- `Project/` — plan, schedule, objectives, roles, development log.
- Folders carry the "what kind" job. Add a new top-level folder only when a genuinely new category appears (e.g. `PDL Specification/`, `Prompt Engineering/`); update the MOC when you do.

## Git workflow

The vault is a git repo with a private GitHub remote (`origin`). Use it to make every pass safe and reversible.

- **Sync first.** Begin every pass with `git fetch origin` so your view of the remote is current — do this before making any claim about merge/push state. Then sync local `main` to the remote (`git checkout main && git pull`) and cut the new branch from there; I merge PRs on the GitHub website, so local `main` is usually behind and a branch cut from stale `main` builds on the wrong base.
- **Branch, never `main`.** Start each pass on a fresh branch named `reorg/YYYY-MM-DD`. Never commit directly to `main`.
- **One branch → one PR.** Once a branch's PR is merged, don't keep committing on it — that diverges it from `main` and orphans the new work in a second PR. Start a fresh branch (from re-synced `main`) for the next batch instead. Don't `pull` into an active `reorg/` branch mid-pass; these branches are solo and short-lived, so there's nothing to pull and it only risks merge noise.
- **Incremental commits**, one per logical move, with a `verb: description` prefix. Verbs: `split:`, `merge:`, `promote:`, `tag:`, `moc:`. Examples: `split: June 1 note into 5 atomic notes`, `promote: Process Variables to its own note`, `tag: add topic/ocr (approved)`.
- **Push the branch at the end of each pass** — one backup point per session. Pushing a branch is safe; it doesn't touch `main`.
- **Never push to `main`, never merge.** Merging the branch into `main` is mine to do by hand after I review the diff. Push ≠ merge.

## Safety

- Work on the branch; don't expect anything to reach `main` until I've diffed and merged it myself.
- Never delete content. Worst case, move it (outside the inbox) and flag it with `> [!todo]`.
- When unsure where something belongs, or whether a regroup distorts meaning, leave it in place and ask in your summary rather than guessing.
- End each pass with a short summary: what you split / merged / promoted, any tags you want to add, any gaps flagged, and the branch name you pushed.
