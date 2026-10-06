# Implementation workflow todos

Findings from the chess scaffold run (2026-10-03, `localspec-apply`, 5 chunks, 6 implementers).
Implementers stay minimal: they get the task/chunk only. Escalation lives in the orchestrator.

## Escalation never happened

- [ ] No implementer reported BLOCKED. No chunk went to `rfc`. `questions.md` got no entries.
- [ ] Implementers made their own calls and listed them under DEVIATIONS. The orchestrator copied
      them into `tasks.json` notes and moved on.
- [ ] The BLOCKED bar ("genuinely needs the user") is too vague. It never triggers.
- [ ] Fix: the orchestrator triages DEVIATIONS after each chunk. It stops and moves the chunk to
      `rfc`, with an entry in `questions.md`, when a deviation:
  - changes what a requirement means
  - adds a heavy dependency
  - sends data out or writes outside the project
  - touches secrets, credentials or security defaults
  - contradicts a spec decision
- [ ] Add a user checkpoint after chunk 1.

## Deviations that should have reached the user

- [ ] `@asyncapi/cli` devDependency: `node_modules` went from 184MB to 652MB. It sent a telemetry
      event to NewRelic and writes `~/.asyncapi-analytics`.
- [ ] Missing `/assets/*` returns `index.html` with 200. It should be 404.
- [ ] Prod `force_ssl` exempts only localhost. A plain-HTTP probe on `/api/health` gets redirected.
- [ ] Postgres moved to host port 5433. The justfile falls back from `docker compose` to `docker-compose`.
- [ ] Chunk 03 deleted `ui/public`, against the spec decision. Chunk 05 recreated it. The orchestrator
      didn't catch the contradiction.

## Safety

- [ ] The chunk 01 implementer ran `cat ~/.docker/config.json` and printed ECR auth tokens into
      the transcript. The "stay inside the project" rule was added to prompts only after that.
      Make it a permissions deny rule (e.g. `Read(~/.docker/**)` and other credential paths), not
      prompt text.
- [ ] An implementer wrote a stray `~/openapi.json` (it was deleted). Writes outside the project root
      should be denied by default.

## Worked well (keep)

- [ ] The orchestrator caught an untested requirement (R25, several topics on one socket) and
      sent a follow-up implementer.
- [ ] NOTES-FOR-NEXT handoffs between chunks were useful.
