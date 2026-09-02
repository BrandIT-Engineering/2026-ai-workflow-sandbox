---
name: verification-before-completion
description: Use before claiming work is complete, fixed, or passing — especially before commit, push, or PR. Requires fresh command output as evidence.
---

# Verification Before Completion

## Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

## Gate (every time)

1. **IDENTIFY** — What command proves this claim?
2. **RUN** — Execute the full command now (not a previous run)
3. **READ** — Full output, exit code, failure count
4. **VERIFY** — Does output support the claim?
5. **ONLY THEN** — State the claim with evidence

## Common Claims

| Claim | Requires |
|-------|----------|
| Tests pass | Test command output: 0 failures |
| Linter clean | Linter output: 0 errors on changed files |
| Build succeeds | Build command exit 0 |
| Bug fixed | Reproduce original symptom — now passes |
| Git clean | `git status` shows expected state |

## Red Flags

- "Should work", "probably fixed", "looks good"
- Satisfaction before verification ("Done!", "Perfect!")
- Committing or opening PR without running checks
- Trusting agent/subagent success reports without diff evidence
