---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior — before proposing or applying fixes.
---

# Systematic Debugging

## Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

## Four Phases (complete each before the next)

### 1. Root Cause Investigation

- Read full error messages and stack traces
- Reproduce reliably; note exact steps
- Check recent changes (`git log`, `git diff`)
- Form a hypothesis; gather evidence to confirm or reject it

### 2. Pattern Analysis

- Find working examples in the same codebase
- Compare broken vs working paths
- Identify what's different (config, data, timing, environment)

### 3. Hypothesis and Minimal Fix

- State root cause in one sentence
- Design the smallest fix that addresses the cause (not the symptom)
- Consider edge cases the fix might break

### 4. Verify

- Run the failing test/command again — must pass
- Run related tests to catch regressions
- Use `verification-before-completion` before claiming fixed

## Red Flags — STOP

- "Quick fix while I investigate"
- Changing code without reproduction
- Multiple fixes in a row without understanding why
- "It works on my machine" without evidence
