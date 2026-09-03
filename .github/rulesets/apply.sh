#!/usr/bin/env bash
# Bu script'i CI/agent ÇALIŞTIRMAZ — sadece repo sorumlusu (m_berber) elle çalıştırır.
# Kullanım: .github/rulesets/apply.sh
set -euo pipefail

REPO="BrandIT-Engineering/2026-ai-workflow-sandbox"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "-> dev-protection ruleset uygulanıyor..."
gh api "repos/${REPO}/rulesets" \
  --method POST \
  --input "${DIR}/dev.json"

echo "-> main-protection ruleset uygulanıyor..."
gh api "repos/${REPO}/rulesets" \
  --method POST \
  --input "${DIR}/main.json"

echo "Bitti. Kontrol için: gh api repos/${REPO}/rulesets"
echo "NOT: main.json, 'PR kaynağı yalnızca dev olsun' kuralını içermez — GitHub"
echo "rulesets bunu native desteklemiyor. Bu kural AGENTS.md/CLAUDE.md'de"
echo "konvansiyon olarak ve review sırasında (reviewer PR base+head kontrolü) uygulanır."
