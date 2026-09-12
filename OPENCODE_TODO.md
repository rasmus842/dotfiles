# OpenCode workflow backlog

`TODO.md` contains the raw ideas. This file records follow-up work that should not be folded into the current planner and implementer workflow yet.

## Spec lifecycle

- Decide the canonical feature spec path and naming convention under `spec/`.
- Decide whether reviewer approval is required or advisory. Current policy treats it as an advisory quality gate, with Rasmus as the final approver.
- Define what counts as a substantive spec change that requires another independent review.
- Decide how approved specs record the approving user message and base revision.
- Decide when a feature is too large and must be split into separately approved specs.

## Git and worktrees

- Design one branch and worktree per approved feature.
- Record ownership of pre-existing working-tree changes before implementation starts.
- Discover the repository's default branch instead of assuming `master` or `main`.
- Define explicit approval boundaries for commit, push, PR creation, merge, release, branch deletion, reset, clean, rebase, and force-push.
- Keep merge manual until branch protection, identity, approval records, and recovery behavior are reliable.

## GitHub and PR workflow

- Evaluate `gh` and `gh-axi` for read-only PR metadata, checks, reviews, comments, and mergeability.
- Define durable state linking a spec, worktree, branch, session, PR, and review round.
- Add scoped write operations only after the read-only workflow is reliable.
- Decide how fixup commits, autosquash, conflicts, stale branches, closed PRs, and unresolved comments are handled.
- Never bypass failed checks or unresolved blocking review comments.

## Slack integration

- Evaluate a Slack MCP for notifications, questions, and approvals.
- Map each feature or PR to one Slack thread with stable question and approval IDs.
- Keep workflow state outside Slack. Slack is a communication channel, not memory or the source of truth.
- Define authorized approvers, channel allowlists, redaction rules, retries, timeouts, cancellation, and stale approval behavior.
- Do not publish code, create PRs, deploy, or mutate databases based on an ambiguous Slack response.

## Code review

- Keep spec review and code review separate.
- Decide whether to add an independent `code-reviewer` agent after implementation.
- Compare local static analysis, custom lint rules, CodeRabbit, Greptile, and security scanners using signal quality and false-positive rates.
- Require code review to compare the complete feature diff with the approved spec and cite exact files and lines.
- Define blocker, important, suggestion, and nit severities.
- Track which commit addresses each finding and require independent verification before resolution.
- Keep Rasmus's review as the final quality and product judgment even when automated reviewers pass.

## Quick-agent coverage

- Add command families only for ecosystems in active use. Avoid arbitrary shell escape hatches.
- Consider canonical project commands such as `just test`, `just lint`, `just format`, and `just check`.
- Consider a separate `quick-typecheck` agent rather than hiding type checking under linting.
- Decide whether `quick-format` may run safe Git diff commands to report exactly which files changed.

## OpenCode maintenance

- Document OpenCode symlinks, required environment variables, validation commands, and restart behavior in `README.md`.
- Revisit `subagent_depth` when planner runs as a subagent. The current depth of 2 supports planner as primary, then implementer, then quick workers.
- Smoke-test TUI keybindings and restore an agent picker if cycling with Tab becomes awkward.
- Revisit the `unslop` skill. Technical specs may benefit from a smaller `concise-technical-writing` skill instead.
