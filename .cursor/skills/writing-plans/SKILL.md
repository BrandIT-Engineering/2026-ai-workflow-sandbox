---
name: writing-plans
description: Use after architectural design approval for multi-step implementation. Creates bite-sized task plans before touching code.
---

# Writing Plans

Use after `brainstorming` approves an architectural design.

## Output

Save plan to: `docs/plans/YYYY-MM-DD-<feature-name>.md`

## Plan Structure

```markdown
# [Feature] Implementation Plan

## Goal
One paragraph — what and why.

## Files
- `path/to/file` — what changes

## Tasks
### Task 1: [name]
**Files:** ...
**Steps:**
1. Write failing test
2. Implement
3. Verify
**Commit:** `type(scope): message`
```

## Rules

- Bite-sized tasks (2–5 min steps)
- Each task independently testable
- Include exact file paths and commands
- DRY, YAGNI, TDD per task
- Reference `git-workflow` for branch/PR steps

## After Plan

Get user approval on the plan, then execute task by task with `verification-before-completion` at each gate.
