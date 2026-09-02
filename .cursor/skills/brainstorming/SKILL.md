---
name: brainstorming
description: Use before any creative work — new features, components, behavior changes, or workflow setup. Explores intent and presents a design for approval before implementation.
---

# Brainstorming

## Hard Gate

Do NOT write code, scaffold, or implement until you present a design and get explicit approval.

## Classify First (say it out loud)

- **Spike** — feasibility question; quick probe, report recommendation, throwaway code OK
- **Bounded** — small change to existing code in this repo; short design in chat, then wait for yes
- **Architectural** — new subsystems or multi-file restructuring; full design, then use `writing-plans`

When in doubt, take the heavier path.

## Bounded Path (most common)

1. Explore project context (read relevant files)
2. Ask clarifying questions one at a time if needed
3. Present short design: approach, files touched, how to verify
4. **STOP — wait for approval**
5. Then implement (use `git-workflow`, `test-driven-development` as needed)

## Architectural Path

1. Explore context
2. Propose 2–3 approaches with trade-offs
3. Present design in sections, get approval per section
4. Invoke `writing-plans` for implementation plan
5. Execute plan with review checkpoints

## Anti-Pattern

"This is obvious, I'll start coding" — always present intent first, even for small tasks.
