#!/usr/bin/env bash
# Scaffold a new spec under <project>/localspec/specs/<spec-id>/.
#
# Usage: new-spec.sh <spec-id> [title]
#
#   <spec-id>  ticket key when there is one (GLIA-1234-fix-table-view),
#              otherwise YYYY-MM-DD-<slug>
#   [title]    human readable title; defaults to the spec-id
set -euo pipefail
. "$(dirname "$0")/lib.sh"

id="${1:-}"
[ -n "$id" ] || die "usage: new-spec.sh <spec-id> [title]"
title="${2:-$id}"

case "$id" in
  */*|.*) die "spec-id must be a plain directory name" ;;
esac

root="$(project_root)"
dir="$(spec_dir "$id")"
[ -e "$dir" ] && die "spec already exists: $dir"

tpl="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$dir/chunks"
sed -e '/^<spec-template>$/d' -e '/^<\/spec-template>$/d' "$tpl/SPEC_TEMPLATE.md" > "$dir/spec.md"
cp "$tpl/QUESTIONS_TEMPLATE.md" "$dir/questions.md"
jq -n --arg spec "$id" --arg title "$title" --arg created "$(date -u +%Y-%m-%d)" \
  '{spec: $spec, title: $title, created: $created, chunks: []}' > "$dir/tasks.json"

# localspec/ holds solo, gitignored spec state - the stand-in for openspec/.
ignore="$root/.gitignore"
if ! { [ -f "$ignore" ] && grep -qx 'localspec/' "$ignore"; }; then
  printf '\n# solo, local-only specs (stand-in for openspec)\nlocalspec/\n' >> "$ignore"
  printf 'added localspec/ to %s\n' "$ignore"
fi

printf 'created %s\n' "$dir"
printf '  %s/spec.md\n  %s/tasks.json\n  %s/questions.md\n  %s/chunks/\n' "$dir" "$dir" "$dir" "$dir"
printf 'next: fill in spec.md, then add chunks with add-chunk.sh %s <slug> "<title>"\n' "$id"
