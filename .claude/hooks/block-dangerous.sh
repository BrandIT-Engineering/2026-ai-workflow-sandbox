#!/bin/sh
# PreToolUse hook (matcher: Bash). Bilinen tehlikeli komutları erken yakalar.
# Bu katman güvenilir DEĞİLDİR — asıl duvar .githooks/'tur, bkz. AGENTS.md.
input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)
[ -n "$cmd" ] || exit 0

deny() {
  echo "$1" >&2
  exit 2
}

case "$cmd" in
  *"--force-with-lease"*)
    : # açıkça izinli, aşağıdaki force-push kontrolüne düşmesin
    ;;
  *"git push --force"*|*"git push -f "*)
    deny "Force-push yasak. Yalnızca 'git push --force-with-lease' kullan." ;;
esac

case "$cmd" in
  *"rm -rf"*)
    deny "'rm -rf' bu repoda yasak. Silmeden önce kullanıcıya sor." ;;
  *"git reset --hard"*)
    deny "'git reset --hard' yasak — geri alınamaz iş kaybına yol açar." ;;
  *"git checkout main"*|*"git checkout dev"*|*"git switch main"*|*"git switch dev"*)
    deny "main/dev'e geçiş yasak. Kendi feature branch'inde kal; worktree kullan." ;;
  *"git config --global"*)
    deny "'git config --global' agent tarafından çalıştırılamaz — kullanıcı kendi makinesinde çalıştırmalı." ;;
esac

case "$cmd" in
  *"git push"*main*|*"git push"*dev*)
    deny "main/dev'e push yasak. Bir feature branch'ine push edip PR aç." ;;
esac

case "$cmd" in
  *"git commit"*)
    branch=$(git branch --show-current 2>/dev/null)
    case "$branch" in
      main|dev)
        deny "Şu an '$branch' branch'indesin — burada commit yasak. Önce feature branch aç." ;;
    esac
    ;;
esac

exit 0
