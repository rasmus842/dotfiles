#!/usr/bin/env bash
# Append a chunk to a spec: create chunks/<NN>-<slug>.md and its tasks.json entry.
# The chunk starts in state `wip`.
#
# Usage: add-chunk.sh <spec-id> <slug> <title>
set -euo pipefail
. "$(dirname "$0")/lib.sh"

id="${1:-}"; slug="${2:-}"; title="${3:-}"
[ -n "$id" ] && [ -n "$slug" ] && [ -n "$title" ] || die 'usage: add-chunk.sh <spec-id> <slug> <title>'
require_spec "$id"

case "$slug" in
  *[!a-z0-9-]*) die "slug must be lowercase letters, digits and dashes: $slug" ;;
esac

dir="$(spec_dir "$id")"
tasks="$(tasks_file "$id")"
n=$(( $(jq '.chunks | length' "$tasks") + 1 ))
chunk_id="$(printf '%02d-%s' "$n" "$slug")"
file="$dir/chunks/$chunk_id.md"
[ -e "$file" ] && die "chunk file already exists: $file"

tpl="$(cd "$(dirname "$0")/.." && pwd)/CHUNK_TEMPLATE.md"
sed -e '/^<chunk-template>$/d' -e '/^<\/chunk-template>$/d' \
    -e "s|^# <NN>-<slug>: <Chunk title>$|# $chunk_id: $title|" "$tpl" > "$file"

jq --arg id "$chunk_id" --arg title "$title" --arg updated "$(now_utc)" \
  '.chunks += [{id: $id, title: $title, state: "wip", updated: $updated, notes: []}]' \
  "$tasks" | write_tasks "$id"

printf '%s\n' "$file"
