# Specs Reference

The on-disk contract shared by `/localspec-plan` (planning) and `/localspec-implement` (execution).
`localspec/` is gitignored and solo-only; teams use openspec where it is available.

## Layout

```
localspec/specs/<spec-id>/
  spec.md         # problem, solution, user stories, requirements, architecture, out of scope
  tasks.json      # ordered chunk index + state + notes  <- the ONLY source of truth for state
  questions.md    # append-only question log
  chunks/
    01-<slug>.md  # how to implement one vertical slice
    02-<slug>.md
```

`<spec-id>` is the ticket key when the work has one (`GLIA-1234-fix-table-view`), otherwise
`YYYY-MM-DD-<slug>` (`2026-09-20-fix-table-view`).

## tasks.json

```json
{
  "spec": "GLIA-1234-fix-table-view",
  "title": "Fix the table view",
  "created": "2026-09-20",
  "chunks": [
    {
      "id": "01-parse-config",
      "title": "Read the new YAML keys end-to-end",
      "state": "ready",
      "updated": "2026-09-20T11:04:12Z",
      "notes": ["waits on Q3"]
    }
  ]
}
```

- `chunks` is ordered. Position IS the dependency order - there is no dependency graph.
  Chunk `id` carries the same zero-padded number as its file, `chunks/<id>.md`.
- Never write state anywhere else. A chunk file carrying its own status header will drift
  from this one.
- Written and read with the scripts below, or with `jq`. Always leave it valid JSON.

## States

| state          | meaning                                                  | who moves it out |
| -------------- | -------------------------------------------------------- | ---------------- |
| `wip`          | still being planned, not yet coherent                      | planning agent   |
| `rfc`          | blocked on a human: see `questions.md` or a review request | the user         |
| `ready`        | approved and implementable                                 | implementing agent |
| `implementing` | an agent is working on it right now                        | implementing agent |
| `done`         | Definition of Done met                                     | -                |

Flow: `wip` -> `rfc` -> `ready` -> `implementing` -> `done`. Any state may go back to `rfc`
when a blocking question appears.

**Stale lock:** `implementing` found at the start of a session means a previous run died.
Reset it to `ready` and re-read the chunk from the top; do not assume partial work landed.

## Rules

- `spec.md` is written once and holds everything shared. Chunks never restate it.
- A blocking unknown: append to `questions.md`, set the chunk to `rfc`, stop.
  A non-blocking unknown: record it in the chunk's Risks section with the assumption taken,
  and continue.
- An answered question must be promoted into `spec.md` or the chunk before it counts.
- Specs are living documents: when implementation contradicts the spec, fix the spec.

## Scripts

Planning (`/localspec-plan`):

- `localspec-plan/scripts/new-spec.sh <spec-id> [title]` - scaffold a spec, ensure `localspec/` is gitignored
- `localspec-plan/scripts/add-chunk.sh <spec-id> <slug> <title>` - create the next chunk file and its `tasks.json` entry

Execution (`/localspec-implement`):

- `localspec-implement/scripts/spec.sh list [spec-id]` - specs and their progress
- `localspec-implement/scripts/spec.sh next <spec-id>` - the first chunk that is not `done`
- `localspec-implement/scripts/spec.sh state <spec-id> <chunk-id> <state>` - move a chunk
- `localspec-implement/scripts/spec.sh note <spec-id> <chunk-id> "<text>"` - append a note
