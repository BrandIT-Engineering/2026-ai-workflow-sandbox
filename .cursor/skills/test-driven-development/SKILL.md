---
name: test-driven-development
description: Use when implementing features or bugfixes with test coverage. Write failing test first, then minimal implementation.
---

# Test-Driven Development

## Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Wrote code before the test? Delete it and start from the test.

## Red-Green-Refactor

1. **Red** — Write one failing test for the next behavior
2. **Run** — Confirm it fails for the right reason (not compile error)
3. **Green** — Write minimal code to pass
4. **Run** — Confirm pass
5. **Refactor** — Clean up; tests still pass
6. Repeat

## When to Skip (ask user first)

- Throwaway prototypes
- Pure config/docs changes
- No test framework in repo yet

## With This Repo

- Follow `git-workflow` for commits on a feature branch
- Use `verification-before-completion` before claiming tests pass
