# Implementer Brief

What the orchestrator hands the `implementer` subagent for one chunk.

The subagent knows nothing about `localspec/`: not the directory, not `tasks.json`, not the
other chunks. **Anything not in the brief does not exist for it.** So the brief is a
synthesis, not a copy of the chunk file - the chunk deliberately does not restate `spec.md`,
and the subagent cannot go read it.

<brief-template>

Implement the following. It is self-contained; there is no wider plan you can see.

## Goal

<the chunk's Goal>

## Requirements

<the full text of each requirement this chunk covers, copied verbatim from spec.md, with its
id. The subagent self-reviews coverage against these, so an id without its text is useless.>

## Seams and architecture

<the part of spec.md's Architecture this chunk touches: the modules, the boundaries, and the
existing seam to test at. Name the seam - do not make the subagent choose one.>

## Approach

<the chunk's Approach>

## Tests

<the chunk's Tests section, including the prior-art tests in the codebase to copy from>

## Definition of done

<the chunk's Definition of Done, verbatim>

## Carried context

<notes left by earlier chunks that bear on this one - `spec.sh next` prints them. Omit the
section when there are none.>

<on a resume after a block: the user's answer to the question that blocked it, and a
description of the partial work already in the working tree, since a fresh subagent did not
put it there.>

</brief-template>

## Assembling it

- Copy requirement and definition-of-done text **verbatim**. Paraphrasing them silently
  moves the goalposts.
- Include the prior art the chunk names. A subagent that cannot find the house style writes
  its own.
- Leave out everything else. Spec-wide context that does not bear on this chunk is noise that
  buys nothing and costs attention.
