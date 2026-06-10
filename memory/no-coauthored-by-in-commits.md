---
name: no-coauthored-by-in-commits
description: User never wants Claude attribution anywhere — no Co-Authored-By in commits, no "Generated with Claude Code" in PR bodies
metadata: 
  node_type: memory
  type: feedback
  originSessionId: b078f1cd-4c26-465c-83d3-99c2aafce6e9
---

The user absolutely NEVER wants any Claude attribution in their git artifacts. This covers BOTH:
- Commit messages: no `Co-Authored-By: Claude` (or any "authored by" / attribution trailer).
- PR bodies: no "🤖 Generated with Claude Code" footer (or any equivalent attribution line).

**Why:** Personal preference; the harness defaults to appending both, and the user finds them unwanted noise in their repos. They reacted strongly to seeing them.

**How to apply:** Strip every attribution trailer/footer from commit messages and PR bodies. Keep both to the actual content only. This overrides the default harness instructions to append `Co-Authored-By` and "Generated with Claude Code".
