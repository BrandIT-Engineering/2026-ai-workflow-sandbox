#!/bin/sh
# PreToolUse hook (matcher: Edit|Write). Korumalı ve paylaşılan dosyaları korur.
input=$(cat)
path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
tool=$(printf '%s' "$input" | jq -r '.tool_name // empty' 2>/dev/null)
[ -n "$path" ] || exit 0

deny() {
  echo "$1" >&2
  exit 2
}

case "$path" in
  *.env|*.env.*|*/.git/*|*/.githooks/*|*/package-lock.json|*/go.sum|package-lock.json|go.sum)
    deny "'$path' korumalı bir dosya, agent değiştiremez. Kullanıcı elle düzenlemeli." ;;
esac

case "$path" in
  */test.md|test.md)
    if [ "$tool" = "Write" ]; then
      deny "test.md paylaşılan bir dosya — Write ile üzerine yazılamaz. Yalnızca Edit ile sona ekleme yap."
    fi
    ;;
esac

exit 0
