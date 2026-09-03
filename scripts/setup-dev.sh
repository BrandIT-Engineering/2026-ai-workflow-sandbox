#!/usr/bin/env bash
# Yeni bir ekip üyesinin makinesinde BİR KEZ çalıştırılır. İdempotent'tir —
# iki kez çalıştırmak hata vermez, mevcut ayarı bozmaz.
set -euo pipefail

echo "Hook'lar etkinleştiriliyor (core.hooksPath -> .githooks)..."
git config core.hooksPath .githooks

echo "'git start <isim>' alias'ı tanımlanıyor (origin/dev'den worktree + feature/<kullanici>-<isim> branch'i açar)..."
git config --global alias.start '!f() { name="$1"; if [ -z "$name" ]; then echo "Kullanim: git start <kisa-isim>"; return 1; fi; repo_root=$(git rev-parse --show-toplevel) || return 1; repo_name=$(basename "$repo_root"); branch="feature/${USER}-${name}"; target="$(dirname "$repo_root")/${repo_name}-${name}"; git fetch origin -q; git worktree add "$target" -b "$branch" origin/dev; echo "$target"; }; f'

echo "'git sync' alias'ı tanımlanıyor (fetch + dev'e rebase + force-with-lease push)..."
git config --global alias.sync '!git fetch origin && git rebase origin/dev && git push --force-with-lease'

echo "'git wl' alias'ı tanımlanıyor (worktree list kısayolu)..."
git config --global alias.wl "worktree list"

echo "pull.rebase=true ayarlanıyor (pull her zaman rebase yapsın, merge commit üretmesin)..."
git config --global pull.rebase true

echo "Claude Code statusLine kuruluyor (~/.claude/statusline.sh)..."
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.claude"
cp "$script_dir/statusline.sh" "$HOME/.claude/statusline.sh"
chmod +x "$HOME/.claude/statusline.sh"

settings="$HOME/.claude/settings.json"
if [ -f "$settings" ]; then
  tmp=$(mktemp)
  jq '.statusLine = {"type": "command", "command": "~/.claude/statusline.sh"}' "$settings" > "$tmp" && mv "$tmp" "$settings"
else
  printf '{\n  "statusLine": {"type": "command", "command": "~/.claude/statusline.sh"}\n}\n' > "$settings"
fi

echo "Bitti. Yeni bir iş için: git start <kisa-isim>"
