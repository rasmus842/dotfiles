#!/usr/bin/env bash
# Shared helpers for the spec scripts. Sourced, not run.

die() { printf 'error: %s\n' "$1" >&2; exit 1; }

command -v jq >/dev/null || die "jq is required but not installed"

# Root of the project the specs belong to: the git toplevel, else $PWD.
project_root() {
  git rev-parse --show-toplevel 2>/dev/null || pwd
}

# localspec/ is the tool's root; specs live in localspec/specs/.
localspec_root() { printf '%s/localspec' "$(project_root)"; }

specs_dir() { printf '%s/specs' "$(localspec_root)"; }

spec_dir() {
  local id="${1:?spec-id required}"
  printf '%s/%s' "$(specs_dir)" "$id"
}

tasks_file() { printf '%s/tasks.json' "$(spec_dir "$1")"; }

require_spec() {
  local id="${1:?spec-id required}"
  [ -d "$(spec_dir "$id")" ] || die "no such spec: $id (looked in $(specs_dir))"
  [ -f "$(tasks_file "$id")" ] || die "spec $id has no tasks.json"
}

# Rewrite tasks.json through a temp file so a jq failure cannot truncate it.
write_tasks() {
  local id="$1" tmp
  tmp="$(mktemp)"
  cat > "$tmp"
  jq -e . "$tmp" >/dev/null || { rm -f "$tmp"; die "refusing to write invalid JSON to tasks.json"; }
  mv "$tmp" "$(tasks_file "$id")"
}

now_utc() { date -u +%Y-%m-%dT%H:%M:%SZ; }

VALID_STATES="wip rfc ready implementing done"
