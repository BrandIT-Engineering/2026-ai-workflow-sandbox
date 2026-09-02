---
name: using-skills
description: Use when starting any conversation in this repo. Establishes how to find and apply project skills in .cursor/skills/ before any response or action.
---

# Using Skills

## The Rule

**Invoke relevant skills BEFORE any response or action** — including clarifying questions,
exploring the codebase, or running commands. If a skill might apply, read and follow it.

Announce: "Using [skill-name] to [purpose]".

## Priority

1. Process skills first (brainstorming, systematic-debugging, verification-before-completion)
2. Project skills (git-workflow)
3. Implementation skills (test-driven-development, writing-plans)

## Project Skills (this repo)

| Skill | When |
|-------|------|
| `git-workflow` | Any git branch, commit, push, rebase, or PR work |
| `brainstorming` | New features, behavior changes, creative work |
| `systematic-debugging` | Bugs, test failures, unexpected behavior |
| `verification-before-completion` | Before claiming done, fixed, or passing |
| `test-driven-development` | Implementing features or bugfixes with tests |
| `writing-plans` | Multi-step or architectural work after design approval |

## Skill Locations

- Project skills: `.cursor/skills/<name>/SKILL.md`
- Team workflow rules: `AGENTS.md` (always read for git/PR work)

## Red Flags

| Thought | Reality |
|---------|---------|
| "Too simple for a skill" | Simple tasks still need the right skill |
| "I need context first" | Skills come before exploration |
| "I remember this skill" | Read the current file every time |

User instructions in `AGENTS.md` and direct user requests override skills.
