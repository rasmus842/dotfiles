# Claude Code plugins

Local-only marketplace. This directory is the marketplace root; it is never
published. Skills are vendored and restructured to the plugin layout (no symlinks).

```
.claude-plugin/marketplace.json      # marketplace "my-claude-code-plugins"
plugins/engineering/
  .claude-plugin/plugin.json
  skills/<skill>/SKILL.md
plugins/productivity/
  .claude-plugin/plugin.json
  skills/<skill>/SKILL.md
docs/                                # reference pages, not shipped in either plugin
```

`<plugin-root>/skills/<skill>/SKILL.md` is the layout Claude Code scans.

Manifest fields: `plugin.json` requires only `name`. `marketplace.json` requires
`name`, `owner` (object) and `plugins[]` with `name` + `source`. Per-plugin `author`
is optional and omitted here. For a directory source the marketplace id comes from
the directory name, not the manifest `name`.

A skill's id comes from its **directory** name, not the `name:` in SKILL.md
frontmatter — the frontmatter is only a fallback.

## Install

    /plugin marketplace add ~/dotfiles/my-claude-code-plugins
    /plugin install engineering@my-claude-code-plugins
    /plugin install productivity@my-claude-code-plugins

Invoked namespaced: `/productivity:handoff`, `/engineering:to-spec`.
Namespacing also resolves the clash with this repo's own `skills/handoff`.

After editing a skill, refresh the installed copy:

    /plugin marketplace update my-claude-code-plugins

## Try without installing

    claude --plugin-dir ./plugins/productivity
    claude --plugin-dir ./plugins/productivity plugin details productivity

## Context cost

Measured with `claude plugin details`:

| plugin        | skills | always-on  |
|---------------|--------|------------|
| engineering   | 18     | ~1,216 tok |
| productivity  | 6      | ~246 tok   |

`disable-model-invocation: true` skills are not free — each still costs ~30-50
always-on tokens so the slash command can be listed. It only stops the model from
firing them on its own.

11 of the 24 skills are model-invocable (no `disable-model-invocation`):
`grilling`, `writing-for-agents`, and 9 engineering skills including `code-review`,
`tdd`, `codebase-design`. Do not blanket-disable them: `grill-with-docs` calls
`grilling` and `implement` calls `tdd`; disabling breaks those chains.

## Naming

Upstream attribution and external doc links have been stripped throughout.
Two skills were renamed from their upstream names: `ask-help` (router) and
`setup-skills` (run-once repo configuration).
