---
name: localspec-implement
description: "Implement a persisted spec chunk by chunk"
disable-model-invocation: true
---

Work through a spec, one chunk at a time.
Never edit spec files (`tasks.json`, `chunks`) directly.
Use only `localspec-implement/scripts/spec.sh` script:

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
check the working tree before writing anything.

## The loop

Repeat until `next` reports `ALL DONE` or the next chunk is not `ready`.

### 1. Load context

Read `spec.md` in full, then the chunk file. The chunk deliberately does not restate the
spec; you need both. Read the chunk's notes from `spec.sh next` - earlier chunks leave
warnings there.

### 2. Claim it

```
spec.sh state <spec-id> <chunk-id> implementing
```

A chunk in `wip` or `rfc` is NOT implementable. Stop and tell the user.

### 3. Implement

Follow the chunk's Approach, at the seams the spec's Architecture section names. Write the
tests the chunk's Tests section describes.

Deviating from the Approach is fine when the code disagrees with it - the plan was written
without the keyboard. Record the deviation with `spec.sh note` and, if it changes a decision
that outlives this chunk, fix `spec.md` too.

### 4. Handle unknowns

- **Blocking** (you cannot proceed without a human decision): append the question to
  `questions.md`, set the chunk to `rfc`, stop and tell the user what you need. Do not guess
  your way past a decision that is the user's to make.
- **Non-blocking**: record it in the chunk's Risks and Open Questions section together with
  the assumption you took, and continue.

### 5. Verify

Work through the chunk's Definition of Done item by item. Run the tests and whatever the
project uses to check the build. **Do not mark a chunk `done` on unverified work** - if a
check fails and you cannot fix it, note why and leave the chunk `implementing` or move it to
`rfc`.

### 6. Close it out

```
spec.sh note <spec-id> <chunk-id> "<what the next chunk needs to know>"
spec.sh state <spec-id> <chunk-id> done
```

Append anything the next chunk should know to the chunk file's Notes section: surprises,
deviations, things that turned out to be harder than the spec assumed.

### 7. Next

Report to the user what landed and what is next, then continue with the following chunk.
Commit between chunks if the user wants commits - each chunk is a coherent unit of work.

## Finishing

When every chunk is `done`, check the spec's own Definition of Done, review `questions.md`
for anything still open, and tell the user. Leave the spec directory in place; `localspec/` is
gitignored.
