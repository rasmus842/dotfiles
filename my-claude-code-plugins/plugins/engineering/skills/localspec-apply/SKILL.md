---
name: localspec-apply
description: "Orchestrate a localspec: work the chunks in order, delegating each to an implementer subagent"
disable-model-invocation: true
---

Work a spec chunk by chunk. **You orchestrate; you do not write code.** Each chunk is
delegated whole to the `implementer` subagent.

The split is strict:

- **You** own `localspec/`: `tasks.json`, the chunk files, `questions.md`, ordering, state.
- **The subagent** owns the code. It has never heard of `localspec/` and must not need to.

The brief you hand down and the report you get back are the only channel between the two.
Anything not in the brief does not exist for the subagent; anything not in its report is lost.
Assemble the brief per `BRIEF.md`.

Never edit spec files (`tasks.json`, `chunks`) directly. Use only
`scripts/spec.sh`:

```
spec.sh list [spec-id]
spec.sh next <spec-id>
spec.sh state <spec-id> <chunk-id> <state>
spec.sh note <spec-id> <chunk-id> "<text>"
```

## Start of session

If the user did not name a spec, run `spec.sh list` and ask which one.

Run `spec.sh next <spec-id>`. If it returns a chunk in state `implementing`, a previous run
died: reset it to `ready` and start the chunk from the top. Do not assume partial work landed -
check the working tree before delegating anything.

## The loop

Repeat until `next` reports `ALL DONE` or the next chunk is not `ready`. A chunk in `wip` or
`rfc` is NOT implementable: stop and tell the user why.

### 1. Load context

Read `spec.md` in full, then the chunk file, then the chunk's notes from `spec.sh next` -
earlier chunks leave warnings there. You need all three; the chunk alone is not enough.

### 2. Assemble the brief

Build the brief from `BRIEF.md`. This is the step that decides whether the chunk succeeds.
Requirement text and definition of done go in verbatim; the seam is named, not left open.

### 3. Claim it and delegate

```
spec.sh state <spec-id> <chunk-id> implementing
```

Then spawn **one** `implementer` subagent with the brief. One subagent per chunk.
Do not drive red/green cycles yourself, and do not split a chunk across subagents; a chunk is sized for exactly one context.

### 4. Act on the report

The subagent reports an outcome - done, blocked, or failed - along with what it covered, how
it verified, where it deviated, and what the next chunk should know

**Done** - verify before you believe it:

- Re-run the verification yourself. The agent reporting success is the one that wants to have
  succeeded; "I ran the tests" is the cheapest thing it can say.
- Every requirement the chunk claimed must name a test. One without a test is not covered, and
  the chunk is not done.
- Walk the chunk's Definition of Done item by item against what you can actually observe.
- Check `git log` and `git status`. The subagent commits its own work. A clean tree with no new
  commit means nothing landed; an uncommitted diff means it stopped short. Either way the chunk
  is not done - flag it to the user, do not commit on its behalf.

If any of that fails, treat the report as failed.

Then close it out:

```
spec.sh note <spec-id> <chunk-id> "<what the next chunk needs to know>"
spec.sh state <spec-id> <chunk-id> done
```

Append any deviations to the chunk file's Notes section. If a deviation changes a decision that
outlives this chunk, fix `spec.md` too - a spec that disagrees with the code is worse than no
spec.

**Blocked** - the subagent hit a decision the user owns:

- Append the question to `questions.md` as an entry tagged with this chunk, status `open`.
- Record the state of the working tree with `spec.sh note` - partial work stays in the tree,
  uncommitted, and a fresh subagent will not know it is there.
- `spec.sh state <spec-id> <chunk-id> rfc`, then stop and put the question to the user.

Do not answer it yourself, and do not delegate the same chunk again hoping for a different
outcome.

**Failed** - verification would not go green. Delegate once more with the failure report
appended to the brief. If the second attempt fails too, stop and hand the user the failure;
leave the chunk `implementing` and say so. Do not keep spending attempts.

### 5. Next

Report to the user what landed and what is next, then continue with the following chunk.

## Resuming a blocked chunk

Once the user answers, promote the answer into `spec.md` or the chunk that needs it and mark
the entry `answered` in `questions.md`. An answer that only lives in the question log will be
lost.

Then move the chunk back to `ready` and delegate afresh. The new brief must carry both the
answer and a description of the partial work already in the tree - the new subagent did not
put it there and cannot see why it exists.

## Finishing

When every chunk is `done`, check the spec's own Definition of Done, review `questions.md`
for anything still open, and tell the user. Leave the spec directory in place; `localspec/`
is gitignored.
