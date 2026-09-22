---
name: localspec-plan
description: "Turn the current conversation into a persisted spec: requirements, architecture, and an ordered set of implementable chunks"
disable-model-invocation: true
---

Take the current conversation and codebase understanding and persist it as a spec that a
fresh agent can implement later, chunk by chunk.

Read `SPECS_REFERENCE.md` first: it defines the on-disk layout, `tasks.json`, and the
chunk state machine. This skill only describes the planning process.

Specs live in `localspec/specs/` at the project root. `localspec/` is gitignored, solo-only,
and named to signal what it is - a stand-in for `openspec/`. Where the project uses
openspec, use openspec instead - this is for projects where it is not set up.

## Process

### 1. Explore the codebase

If you have not already, explore the code you are about to change. Use the project's domain
glossary vocabulary throughout the spec, and respect any ADRs in the area you are touching.
A spec written without reading the code will be wrong in ways nobody notices until
implementation.

### 2. Scaffold

```
scripts/new-spec.sh <spec-id> "<title>"
```

`<spec-id>` is the ticket key when the work has one, otherwise `YYYY-MM-DD-<slug>`. The
script creates `spec.md`, `tasks.json`, `questions.md` and `chunks/`, and ensures `localspec/`
is gitignored.

### 3. Write `spec.md`

Fill in the scaffolded `spec.md`, which follows `SPEC_TEMPLATE.md`. This file holds
everything shared: problem, solution, user stories, numbered requirements, architecture,
out of scope. Write it once, properly - the chunks will lean on it and must never restate it.

### 4. Agree the seams

Sketch the seams at which the feature will be tested. Prefer existing seams to new ones, and
use the highest seam possible. If new seams are needed, propose them at the highest point you
can. The fewer seams across the codebase the better; the ideal number is one.

**Check with the user that these seams match their expectations**, then record them in the
Architecture section of `spec.md`.

### 5. Slice into chunks

Break the work into chunks, each a vertical slice: a narrow but COMPLETE path through every
layer it touches, verifiable on its own, sized for a single fresh context window. Any
prefactoring comes first - "make the change easy, then make the easy change".

Order matters and is the only dependency mechanism: position in `tasks.json` is the order
they will be implemented in. There is no dependency graph.

For each chunk, in order:

```
scripts/add-chunk.sh <spec-id> <slug> "<title>"
```

then fill in the created file, which follows `CHUNK_TEMPLATE.md`. Each chunk starts in state
`wip`.

### 6. Review with the user

Present the slicing as a numbered list: title, what it delivers end-to-end, which
requirements it covers. Ask:

- Is the granularity right (too coarse / too fine)?
- Is the order right - does anything depend on something later?
- Should any chunks be merged or split?

Iterate. Anything you need the user to answer goes in `questions.md` and the chunk goes to
`rfc` (`scripts/spec.sh state <spec-id> <chunk-id> rfc`).

### 7. Mark approved chunks ready

Approved chunks move to `ready`:

```
scripts/spec.sh state <spec-id> <chunk-id> ready
```

Only `ready` chunks get implemented. Leave anything still under discussion in `wip` or `rfc`.

Tell the user the spec is ready.

## Improving an existing spec

Run this skill again against an existing `<spec-id>` to revise it. The spec is a living
document: when implementation contradicts it, fix the spec. Answered questions in
`questions.md` must be promoted into `spec.md` or the chunk that needs them - a decision
that only exists in the question log is a decision that will be lost. Never edit a `done`
chunk's scope; add a new chunk instead.
