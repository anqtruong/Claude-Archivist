# Vault Context — <PROJECT NAME>

> [!note]
> This is the project overlay for the Archivist. `CLAUDE.md` holds the generic,
> project-agnostic rules; this file holds whatever is specific to *this* vault.
> Claude reads it at the start of every pass and layers it on top of `CLAUDE.md`.
> Fill in the sections below (delete any you don't need) and rename this file to
> `Vault Context.md`. See `examples/Vault Context (example).md` for a
> filled-in example.

## Project

<One or two sentences: what this vault is, what the project is, who it's for.>

## Reference-only sources outside `References/`

<Everything in the `References/` folder is reference-only by default, so usually
this is empty. Only list a document here if you keep it somewhere other than
`References/` and want it treated the same way.>

- `<path>` — <why it's reference-only>

## MOC name

<The default front-door map is `Vault MOC.md`. Set a custom name here if you want
one, e.g. `My Project MOC.md`. Delete this section to keep the default.>

## Tag menu

<The approved topic-only tag menu for this vault, kept in sync with `Tag Index.md`.
Starts empty; grows by the propose-and-wait rule in `CLAUDE.md`.>

- `topic/<example>`

## Folder names

<Pin specific top-level category folder names here if you want them, otherwise
Claude names folders after the themes that emerge. `Unorganized Notes/` (the capture
inbox) is always present.>

- `<Folder Name>/` — <what kind of note lives here>
