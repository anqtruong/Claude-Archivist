#!/usr/bin/env bash
# SessionStart hook — git status + vault-setup snapshot for an Archivist vault.
# Best-effort only: never block or fail session startup.
# Emits JSON with hookSpecificOutput.additionalContext so the report is
# injected into Claude's context (plain stdout is the fallback if jq is absent).

dir="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$dir" 2>/dev/null || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# Refresh remote refs so "merged" / "behind" are accurate. Short timeout, quiet,
# tolerate offline.
timeout 8 git fetch --quiet origin >/dev/null 2>&1 || true

branch="$(git branch --show-current 2>/dev/null)"

# Fetch PR state once up front — gh's MERGED state is authoritative even when the
# PR was squash-merged (original commits are then NOT ancestors of origin/main).
pr_line=""
pr_state=""
if command -v gh >/dev/null 2>&1 && command -v jq >/dev/null 2>&1 && [ -n "$branch" ]; then
  pr_json="$(gh pr view "$branch" --json number,state,reviewDecision,url 2>/dev/null || true)"
  if [ -n "$pr_json" ]; then
    pr_state="$(printf '%s' "$pr_json" | jq -r '.state // ""')"
    pr_line="$(printf '%s' "$pr_json" | jq -r '"#\(.number) \(.state) review=\(.reviewDecision // "none") \(.url)"')"
  fi
fi

report="Git status @ session start (branch: ${branch:-detached HEAD})"
add() { report="${report}"$'\n'"- ${1}"; }

# On main?
if [ "$branch" = "main" ]; then
  add "⚠️ On main — workflow says never commit here; cut a reorg/ branch first."
fi

# Current branch already merged?
#   - gh PR state = MERGED is authoritative and survives squash merges (where the
#     branch's commits are NOT ancestors of origin/main).
#   - A freshly-cut branch sits at the same commit as origin/main (0 commits ahead).
#     That is NOT "merged" — it just hasn't diverged yet — so don't nag to start
#     over. (This was the false positive: `branch -r --contains HEAD` matched
#     origin/main simply because HEAD *was* main.)
if [ -n "$branch" ] && [ "$branch" != "main" ]; then
  ahead="$(git rev-list --count origin/main..HEAD 2>/dev/null || echo 0)"
  case "$ahead" in ''|*[!0-9]*) ahead=0 ;; esac
  if [ "$pr_state" = "MERGED" ]; then
    add "⚠️ This branch's PR is merged — start a fresh branch from re-synced main for new work; don't keep committing here."
  elif [ "$ahead" -eq 0 ]; then
    add "Fresh branch — no commits beyond origin/main yet."
  else
    add "Branch not yet merged into origin/main (${ahead} commit(s) ahead)."
  fi
fi

# Local main behind origin/main?
behind="$(git rev-list --count main..origin/main 2>/dev/null || echo 0)"
case "$behind" in ''|*[!0-9]*) behind=0 ;; esac
if [ "$behind" -gt 0 ]; then
  add "Local main is ${behind} commit(s) behind origin/main — sync before cutting a branch."
fi

# Unpushed commits on current branch?
if [ -n "$branch" ]; then
  unpushed="$(git rev-list --count '@{u}..HEAD' 2>/dev/null || echo 0)"
  case "$unpushed" in ''|*[!0-9]*) unpushed=0 ;; esac
  if [ "$unpushed" -gt 0 ]; then
    add "${unpushed} local commit(s) on ${branch} not pushed to origin."
  fi
fi

# Uncommitted / untracked working-tree paths?
dirty="$(git status --porcelain 2>/dev/null | grep -c .)"
case "$dirty" in ''|*[!0-9]*) dirty=0 ;; esac
if [ "$dirty" -gt 0 ]; then
  add "${dirty} uncommitted/untracked path(s) in the working tree."
fi

# Open/closed PR line (from the up-front lookup).
if [ -n "$pr_line" ]; then
  add "PR for ${branch}: ${pr_line}"
fi

# Open PRs awaiting merge — repo-wide, branch-independent. The branch lookup
# above shows nothing on main (no PR for main), so this surfaces anything still
# open regardless of current branch, matching the merge-on-the-website workflow.
if command -v gh >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
  open_prs="$(gh pr list --state open --json number,title,headRefName,reviewDecision,url \
    --jq '.[] | "#\(.number) \(.title) [\(.headRefName)] review=\(.reviewDecision // "none") \(.url)"' 2>/dev/null || true)"
  if [ -n "$open_prs" ]; then
    while IFS= read -r line; do
      [ -n "$line" ] && add "Open PR awaiting merge: ${line}"
    done <<< "$open_prs"
  fi
fi

# Vault-setup state — does the Archivist's expected structure exist yet?
# Drives the "auto-detect + offer" first-run setup in CLAUDE.md. The MOC name is
# customizable via the project overlay, so match any "*MOC.md" rather than a fixed
# filename.
missing=""
[ -d "Unorganized Notes" ] || missing="${missing}Unorganized Notes/, "
ls *MOC.md >/dev/null 2>&1 || missing="${missing}a *MOC.md, "
[ -f "Tag Index.md" ] || missing="${missing}Tag Index.md, "
if [ -n "$missing" ]; then
  add "Vault structure not set up (missing: ${missing%, }) — offer to scaffold (CLAUDE.md → Vault setup) before reorganizing."
else
  add "Vault structure present (inbox, MOC, Tag Index)."
fi

# Two channels, on purpose:
#   - systemMessage      → printed in the user's terminal (so I can actually see it)
#   - additionalContext  → injected into Claude's context (so it can act on it)
if command -v jq >/dev/null 2>&1; then
  printf '%s' "$report" | jq -Rs '{systemMessage:., hookSpecificOutput:{hookEventName:"SessionStart",additionalContext:.}}'
else
  printf '%s\n' "$report"
fi
exit 0
