#!/bin/sh
# Claude Code statusLine script. stdin: session JSON. Tek jq çağrısı, hızlı.
# jq veya git yoksa çökmez, sade bir satır basar.

input=$(cat)

if ! command -v jq >/dev/null 2>&1; then
  echo "Claude Code"
  exit 0
fi

fields=$(printf '%s' "$input" | jq -r '[(.workspace.current_dir // ""), (.model.display_name // "")] | @tsv' 2>/dev/null)
dir=$(printf '%s\n' "$fields" | cut -f1)
model=$(printf '%s\n' "$fields" | cut -f2)

[ -n "$dir" ] || dir="$PWD"
folder=$(basename "$dir")

if ! command -v git >/dev/null 2>&1; then
  printf '%s | %s\n' "$folder" "$model"
  exit 0
fi

branch=$(git -C "$dir" branch --show-current 2>/dev/null)

case "$branch" in
  main|dev)
    label="🔴 $branch — BURADA ÇALIŞMA"
    ;;
  "")
    label="🌿 (branch yok)"
    ;;
  *)
    label="🌿 $branch"
    ;;
esac

porcelain=$(git -C "$dir" status --porcelain 2>/dev/null)
staged=$(printf '%s\n' "$porcelain" | grep -c '^[MADRC]')
modified=$(printf '%s\n' "$porcelain" | grep -c '^.[MD]')
untracked=$(printf '%s\n' "$porcelain" | grep -c '^??')

# Yerelde önbelleğe alınmış origin/dev'e göre bayatlık — ağ çağrısı yok,
# yalnızca son 'git fetch' ne zaman yapıldıysa onu yansıtır.
behind=$(git -C "$dir" rev-list --count HEAD..origin/dev 2>/dev/null)
[ -n "$behind" ] || behind=0
if [ "$behind" -gt 0 ] 2>/dev/null; then
  stale=" | ⚠ dev'den $behind geride"
else
  stale=""
fi

printf '%s | 📁 %s | %s | +%s ~%s ?%s%s\n' "$label" "$folder" "$model" "$staged" "$modified" "$untracked" "$stale"
