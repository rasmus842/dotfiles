---
name: tdd
description: Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
---

# Test-Driven Development

TDD is the red → green loop. This skill is the reference that makes that loop produce tests worth keeping: what a good test is, where tests go, the anti-patterns, and the rules of the loop. Every section applies on every cycle: consult them before and during the loop, not after.

## What a good test is

Tests verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't. A good test reads like a specification: "user can checkout with valid cart" tells you exactly what capability exists, and it survives refactors because it doesn't care about internal structure.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Seams: where tests go

A **seam** is the public boundary you test at: the interface where you observe behavior without reaching inside. Tests live at seams, never against internals.

**Test only at pre-agreed seams.** No test is written at an unconfirmed seam. You can't test everything, so agreeing the seams up front is how testing effort lands on the critical paths and complex logic instead of every edge case.

Where "agreed" comes from depends on who invoked this skill:

- **A brief from a caller**: the brief names the seams. Those are the agreed seams - do not renegotiate them. If it names none, or the code disagrees with the one it names, pick the seam yourself and report it.
- **The user directly**: write down the seams under test and confirm them before writing any test. Ask: "What's the public interface, and which seams should we test?"

## Anti-patterns

- **Implementation-coupled**: mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks when you refactor but behavior hasn't changed.
- **Tautological**: the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`, a snapshot derived by hand the same way, a constant asserted equal to itself), so it passes by construction and can never disagree with the code. Expected values must come from an independent source of truth: a known-good literal, a worked example, the spec.
- **Horizontal slicing**: writing all tests first, then all implementation. Bulk tests verify _imagined_ behavior: you test the _shape_ of things rather than user-facing behavior, the tests go insensitive to real changes, and you commit to test structure before understanding the implementation. Work in **vertical slices** instead: one test → one implementation → repeat, each test a **tracer bullet** that responds to what the last cycle taught you.

## Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it. Don't anticipate future tests or add speculative features.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle.
- **Refactoring is not part of the loop.** It belongs to the review stage, not the red → green implementation cycle.

## Code Structure

- **Small, specific modules/classes**: Each module or class should have a single, clear responsibility
- **Group by functionality**: Organize files into directories that reflect what the application does, not technical layers
- **Directory structure = application map**: A reader should be able to understand the application's domain by browsing the directory tree
- **Minimize complexity**: Keep implementations simple and minimal. Avoid adding abstractions, extra entry points, or flexibility unless explicitly requested. When in doubt, choose the simpler approach.
- **Less is more**: The less code (or text) the better. Clarity and conciseness are key. Use simple terms and sentences.
- Do not write excessive comments. Code should be readable and self-documenting
- Match conventions of surrounding code — read existing patterns before writing new code
- Comments explain "why", not "what". If the code is self-evident, don't comment

## Testing Standards

- **No mocks** unless absolutely necessary. Only mock full external service clients (HTTP clients, AWS SDK calls). Never mock internal modules, serializers, or intermediate layers
- Integration tests with real AWS resources (e.g. calling a Bedrock model) are encouraged when feasible
- Use existing test helpers and generators — check test support files before creating new ones
- Tests should be compact and readable — minimal setup, clear assertions, no unnecessary abstraction
- Tests should cover the different "happy paths" and failure scenarios comprehensively
- Tests that cover failure scenarios MUST assert things that are not supposed to happen. F.e assert call count to be 0, or use a `refute` method if available. A comment is NOT sufficient.
- Match entire response bodies in assertions if possible, as opposed to individual fields.

# TDD Workflow

1. **Read the requirements** and slice it into pieces
2. **Test**: Write a failing test that encodes the expected behavior
3. **Implement**: Write the minimum code to make the test pass
4. **Repeat** 2-3 until the current piece is complete
5. **Verify**: All tests pass, linter passes, no regressions
6. **Commit**: Use `/commit`

## Subagent Delegation

**NEVER run directly in main context:**

- exploration → **Explore** agent
- Tests → **quick-test** agent
- Linting → **quick-lint** agent
- Formatting → **quick-format** agent

## When to stop and block

Block only on a decision a human owns: product behaviour, a scope question, a tradeoff with no right answer. Anything you can settle by reading the code is not a blocker - settle it and report the assumption. Never guess your way past a decision that is not yours.
Leave your partial work in the tree when you block. Do not revert it.

# Report

End your final message with exactly these fields:

```
OUTCOME: done | blocked | failed
REQUIREMENTS: per requirement id - covered, and the test that covers it; or not covered, and why
VERIFICATION: the exact test and lint commands run, and their results
DEVIATIONS: where the code disagreed with the approach, and what you did instead ("none" if none)
NOTES-FOR-NEXT: what whoever picks up the following piece of work needs to know
QUESTIONS: blocked only - the decision needed, the options you considered, why it is not yours
TREE-STATE: blocked or failed only - what you left in the working tree, and whether tests are green
```

`OUTCOME: done` means the tests and lint actually passed and you saw them pass. If you did
not see them pass, the outcome is `failed`.
