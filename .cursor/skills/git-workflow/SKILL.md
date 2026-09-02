---
name: git-workflow
description: Enforces BrandIT git and PR workflow for this repo. Use for any branch creation, commit, rebase, push, or pull request — before running git or gh commands.
---

# Git Workflow

**Single source of truth:** Read [AGENTS.md](../../../AGENTS.md) and follow it exactly.

## Before Any Git Operation

1. Confirm current branch: `git branch --show-current`
2. Never work directly on `main` or `dev`
3. Never delete or force-push `main` or `dev`

## Standard Flow

```bash
git checkout dev
git pull --rebase origin dev
git checkout -b feature/<kisaltma>-<kisa-aciklama>
# ... work, commit (Conventional Commits) ...
git fetch origin
git rebase origin/dev
git push --force-with-lease   # only on feature branch after rebase
# Open PR targeting dev — do NOT merge unless user asks
```

## Commit Messages

```
<type>(<scope>): <açıklama>
# type: feat, fix, docs, refactor, test, chore
```

## Merge Rules (human maintainer)

- PR target: `dev` (default branch)
- Requires 1 approval
- **Squash & Merge only** (repo setting)
- Feature branch auto-deletes after merge
- `main` only via `dev` → `main` release PR

## Agent Checklist

- [ ] On a `feature/*` branch (not `main`/`dev`)
- [ ] Rebased onto latest `origin/dev`
- [ ] PR targets `dev`
- [ ] No direct push to protected branches
- [ ] Used `--force-with-lease` (never `--force`) after rebase
