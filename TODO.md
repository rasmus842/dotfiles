Planner subagent reviews plan

# TODO delegation

- computer use
- running server, database queries, e2e tests

# Planner agent

## Planner as subagent:

If planner is not main agent and not user facing then
grilling/feedback should be handled by a smart model rather than me.
This "advisor" model should go through the plan.
Will approve if seems sensible, no input needed from me.
If there are questions that need my feedback,

Could configure this on some tiers:
a) low: do not ask me, just implement
b) medium: some issue/notification (in slack), but implement anyways since can change behaviour later anyways.
c) high: stop, needs my feedback (in slack), keep waiting.

## Configure Handoffs for planner

- essentially forking such that a parallel planner agent should get its sub-goal and slice of a spec

## Reserve a git worktree for work

- Check available worktrees and whether or not they have work in progress (Unmerged PR)
- planner should reserve git worktree
- new branch

## Spec structure

What constraint should be adhered to when writing and reviewing specs

- spec/ directory
- subdirectories are feature-scoped (EXAMPLES)
- new improvements or flows are date-scoped (YYYY-MM-DD-{title})

### General specs

General specs - architecture, style, code strucutre are separate subdirs

- architecure/
- code_structure/
- style/

Reviewing and writing the spec

- Consiseness: remove unnecessary slop and redundant information
- Must be human readable
- Must be complete without consistensies

# Implementer agent

## Work trees

- commiting
- implementing fixes via fixup commits
- rebasing previous changes from master. Conflicts require separate attention unless trivial resolution
- if fixup commits are accepted then autosquash rebasing fixup commits

## Commits

- commit messages
- is commit scope good?

## Github CLI

- gh-axi?
- full access to branches that are not master

# Memory

- Slack mcp
- agents add jsonl to channels
- access info using cli/msp and jq

# Grilling, focusing on goal/spec/what-to-do

- currently grill-me instructions
- perhaps lavish-axi for this if this is in user facing session?
- else questions should be written down. User answers them later and then session picks them up later.

# Browser use

- perhaps axi tool?

# Reviewers

- design tools rather than agents that review specific characteristic
- wherever "taste" is involved, should probably use either anthropic models or perhaps kimi-k2.5 or kimi-k3 through some provider
- SOLID principles

## unslop, consiseness

Purely to avoid ai slop: verbosity, confusing language

## design doc, spec reviewing

unslop should cover this
prevet spec that covers too big of a scope or covers too many levels of abstraction

## SOLID

### Single responsibility:

TODO need to figure out exactly what these points actually mean

- Single file/module/class: does it do one thing (one public method/API, rest is private implementation that should not be cared about if it works and is sufficient)
- Open/Closed: open to extension, closed to modification
- Libskov Substitution: is the underlying implementation to this interface/behaviour easily replacable by another implementation? Is it easy to add new features without changing existing code?
- Interface Segregation principle: keep interfaces/behaviours small and focused. Clients or code that uses given interface should not depend on interfaces they do not use.
- Dependency Inversion Principle: High level modules should not depend on low-level modules; both should depend on abstractions.

Single file/module/class: one single function/method exposed to the rest of code. Rest is private and implementation details that rest of the code should not care about
also YAGNI? Do not write unnecessary code

## General "taste", nitpicker

An aggressive nitpicker

# Security

- security audit (best is flagship anthropic or openai models, for example fable-5 or gpt-5.6-sol)
- pentester: should probably be an open source model rather than openai or anthropic model (given that these have extensive safeguards that prevent great pentesting)

# Full e2e worklfow regarding PRs
plan > implement > pr
now: how to pick up PR, comments etc
- should apply fixes (fixup commits)
- another PR round
- if comments resolved and PR approved - rebase --autosquash master
- NOTIFY, manual merge

# Future vision:
1. Tasks/tickets/issues manually to main/planner agent.
2. speccing, implementing, pushes PR.
3. Reviewing
- Some external reviewing agents, perhaps coderabbit, greptile, snyk or something (can be before pr actually)
- Some github jobs that do some review or something
- Me in the loop: notifies me, I write comments, submit review
4. Agent listens to PR periodically
- picks up comments
- fixup commits
- repeat from 3-4 until approved
5. I merge
- perhaps in future let agent merge since I approved already
- goes into merge queue?
- other pending pr-s should fail if conflicts arise
