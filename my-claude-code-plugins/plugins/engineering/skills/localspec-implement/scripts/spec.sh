#!/usr/bin/env bash
# Read and update spec state in <project>/localspec/specs/<spec-id>/tasks.json.
#
# Usage:
#   spec.sh list [spec-id]                     specs and their progress
#   spec.sh next <spec-id>                     the first chunk that is not done
#   spec.sh show <spec-id> [chunk-id]          the tasks.json entries
#   spec.sh state <spec-id> <chunk-id> <state> move a chunk; state is one of
#                                              wip rfc ready implementing done
#   spec.sh note <spec-id> <chunk-id> <text>   append a note to a chunk
set -euo pipefail

lib="$(cd "$(dirname "$0")/../../localspec-plan/scripts" 2>/dev/null && pwd)/lib.sh"
[ -f "$lib" ] || { echo "error: cannot find localspec-plan/scripts/lib.sh" >&2; exit 1; }
. "$lib"

usage() { awk 'NR>1 && /^#/ {sub(/^# ?/, ""); print; next} NR>1 {exit}' "$0"; exit "${1:-1}"; }

chunk_exists() {
  jq -e --arg c "$2" 'any(.chunks[]; .id == $c)' "$(tasks_file "$1")" >/dev/null \
    || die "no such chunk in $1: $2"
}

cmd="${1:-}"; shift || true
case "$cmd" in
  list)
    id="${1:-}"
    if [ -n "$id" ]; then dirs="$(spec_dir "$id")"; else dirs="$(specs_dir)"/*; fi
    shopt -s nullglob
    found=0
    for d in $dirs; do
      [ -f "$d/tasks.json" ] || continue
      found=1
      jq -r '"\(.spec)  [\([.chunks[] | select(.state == "done")] | length)/\(.chunks | length) done]  \(.title)",
             (.chunks[] | "    \(.state | (. + "            ")[0:13])\(.id)  \(.title)")' "$d/tasks.json"
    done
    [ "$found" = 1 ] || die "no specs found under $(specs_dir)"
    ;;

  next)
    id="${1:-}"; [ -n "$id" ] || usage
    require_spec "$id"
    jq -r --arg dir "$(spec_dir "$id")" '
      [.chunks[] | select(.state != "done")] as $todo
      | if ($todo | length) == 0 then "ALL DONE"
        else $todo[0]
          | "id:    \(.id)\nstate: \(.state)\ntitle: \(.title)\nfile:  \($dir)/chunks/\(.id).md"
            + (if (.notes | length) > 0 then "\nnotes: " + (.notes | join("; ")) else "" end)
        end' "$(tasks_file "$id")"
    ;;

  show)
    id="${1:-}"; [ -n "$id" ] || usage
    require_spec "$id"
    if [ -n "${2:-}" ]; then
      chunk_exists "$id" "$2"
      jq --arg c "$2" '.chunks[] | select(.id == $c)' "$(tasks_file "$id")"
    else
      jq . "$(tasks_file "$id")"
    fi
    ;;

  state)
    id="${1:-}"; chunk="${2:-}"; state="${3:-}"
    [ -n "$id" ] && [ -n "$chunk" ] && [ -n "$state" ] || usage
    require_spec "$id"; chunk_exists "$id" "$chunk"
    case " $VALID_STATES " in *" $state "*) ;; *) die "invalid state: $state (want: $VALID_STATES)" ;; esac
    jq --arg c "$chunk" --arg s "$state" --arg u "$(now_utc)" \
      '(.chunks[] | select(.id == $c)) |= (.state = $s | .updated = $u)' \
      "$(tasks_file "$id")" | write_tasks "$id"
    printf '%s %s -> %s\n' "$id" "$chunk" "$state"
    ;;

  note)
    id="${1:-}"; chunk="${2:-}"; text="${3:-}"
    [ -n "$id" ] && [ -n "$chunk" ] && [ -n "$text" ] || usage
    require_spec "$id"; chunk_exists "$id" "$chunk"
    jq --arg c "$chunk" --arg n "$text" --arg u "$(now_utc)" \
      '(.chunks[] | select(.id == $c)) |= (.notes += [$n] | .updated = $u)' \
      "$(tasks_file "$id")" | write_tasks "$id"
    printf '%s %s note added\n' "$id" "$chunk"
    ;;

  ""|-h|--help|help) usage 0 ;;
  *) die "unknown command: $cmd" ;;
esac
