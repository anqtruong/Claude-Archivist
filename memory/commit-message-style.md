---
name: commit-message-style
description: "User's preferences for git commit messages (conciseness, no author trailer)"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: a56faed7-43af-429d-8447-c8e2c19ea41f
---

Keep commit messages concise. Do NOT add a "Co-Authored-By: Claude" trailer (or any author attribution) to commits.

**Why:** The user wants commit messages to focus on the content of the change, not on who/what authored it.

**How to apply:** Prefer a short subject line, minimal or no body. Omit the Co-Authored-By line entirely, overriding the default harness guidance to add it.
