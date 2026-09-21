<chunk-template>

# <NN>-<slug>: <Chunk title>

A chunk is one vertical slice of the spec: a narrow but COMPLETE path through every layer
it touches, verifiable on its own, sized to fit in a single fresh context window.

The chunk does NOT restate the spec. Problem, solution, user stories, requirements and
architecture live once in `spec.md`; the reader has it open. This file answers only
"how do I build this slice, and how do I know it works".

## Goal

One or two sentences: the behaviour that works after this chunk that did not work before.

## Requirements Covered

The `spec.md` requirement IDs this chunk satisfies (R1, R4). If a chunk covers no
requirement, question whether it should exist.

## Approach

The steps to take, in order, at the level of modules and their interfaces. Enough that a
fresh agent does not have to re-derive the design, but no more.

Do NOT include specific file paths or code snippets. They go stale fast.

Exception: if a prototype produced a snippet that encodes a decision more precisely than
prose can (state machine, reducer, schema, type shape), inline it within the relevant step
and note briefly that it came from a prototype. Trim to the decision-rich parts.

## Tests

Which tests to write or extend, at which seam, and the prior art in the codebase to copy
from. Test external behaviour, not implementation details.

## Definition of Done

A checklist that decides this chunk is `done`. Each item must be objectively checkable -
a command that passes, a behaviour that can be demonstrated. "Code is clean" is not an item.

- [ ] Criterion 1
- [ ] Criterion 2

## Risks and Open Questions

What might not hold, and anything unresolved. A question that BLOCKS implementation goes in
`questions.md` and flips this chunk to `rfc`; a question that does not block is recorded here
together with the assumption taken.

## Notes

Left empty at planning time. The implementing agent appends what it learned - surprises,
deviations from the approach, things the next chunk needs to know.

</chunk-template>
