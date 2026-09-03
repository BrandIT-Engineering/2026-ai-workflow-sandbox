# BrandIT Engineering — AI Agent Workflow

Bu dosya, bu repoda çalışan tüm AI agent'lar (Claude Code, Codex, OpenCode, Cursor, vb.) ve
ekip üyeleri için **tek kaynak** branch ve merge workflow kuralıdır. Kurallara uymak zorunludur.

## Branch Yapısı

| Branch | Rol | Koruma |
|--------|-----|--------|
| `main` | Production / release | Korumalı — asla silinemez, doğrudan push yasak |
| `dev` | Entegrasyon / default branch | Korumalı — asla silinemez, doğrudan push yasak |
| `feature/<isim>` | Her iş için geçici branch | PR merge sonrası **otomatik silinir** |

- Varsayılan branch **`dev`**'dir. Yeni branch'ler her zaman güncel `dev`'den açılır.
- **`main` ve `dev` asla silinmez, force-push edilmez, doğrudan push edilmez.**

## İş Akışı (Her Görev İçin)

1. **Branch aç:** Çalışmaya başlamadan önce güncel `dev`'den yeni branch aç.

   ```bash
   git checkout dev
   git pull --rebase origin dev
   git checkout -b feature/<kisaltma>-<kisa-aciklama>
   ```

2. **Çalış ve commit et:** Anlamlı, küçük commit'ler. Mesaj kuralı (Conventional Commits):

   ```
   <type>(<scope>): <açıklama>
   # type: feat, fix, docs, refactor, test, chore
   ```

3. **Rebase et (ZORUNLU):** İş bitince, merge etmeden önce `dev`'i kendi branch'ine rebase et.
   Rebase ile update edilmeden `dev`'e merge yapılamaz (linear history zorunlu).

   ```bash
   git fetch origin
   git rebase origin/dev
   # conflict varsa çöz, sonra:
   git push --force-with-lease
   ```

4. **PR aç:** Hedef branch **her zaman `dev`**. Başlık ve açıklama net olsun.

5. **Review & Merge:** En az **1 onay** sonrası repo sorumlusu **Squash & Merge** ile birleştirir.
   - Repoda yalnızca **Squash & Merge** açıktır (merge commit ve rebase merge kapalı).
   - Merge sonrasında feature branch **otomatik silinir** — elle silmek gerekmez.

6. **`main`'e çıkış:** `main`'e sadece `dev`'den açılan bir PR ile (release anında) çıkılır.
   `main`'e asla doğrudan push/merge yapılmaz.

## Agent'lar İçin Kontrol Listesi (Komut Çalıştırmadan Önce)

- [ ] Hangi branch'tayim? → `git branch --show-current` (`main` veya `dev` üzerinde asla iş yapma)
- [ ] `dev` güncel mi? → `git fetch origin && git rebase origin/dev`
- [ ] Commit mesajlarım Conventional Commits kuralına uyuyor mu?
- [ ] PR'ı `dev`'e açıyorum (varsayılan branch)?
- [ ] `main` veya `dev`'i silmeye / force-push etmeye asla çalışmıyorum.

## Yasaklar

- `main` veya `dev`'i silmek, force-push etmek, doğrudan commit/push atmak.
- `dev` güncellenmeden (rebase edilmeden) merge etmek.
- PR'da merge commit veya rebase merge kullanmak (repo yalnızca Squash & Merge'e izin verir).
- Branch koruma kurallarını bypass etmeye çalışmak.

## Zorlama Katmanları

Bu kurallardan hangisi **otomatik engelleniyor**, hangisi **sadece konvansiyon** —
ikincisi agent'ın kendi kendini kontrol etmesine bağlı, bilmek önemli.

**Hook ile zorlanan (deterministik engel):**
- `main`/`dev`'e doğrudan commit → `.githooks/pre-commit`
- `main`/`dev`'e push → `.githooks/pre-push`
- Conventional Commits dışı commit mesajı → `.githooks/commit-msg`
- `rm -rf`, `git reset --hard`, `git checkout main|dev`, `git config --global`,
  force-push (`--force-with-lease` hariç) → `.claude/hooks/block-dangerous.sh`
  (PreToolUse, Bash matcher)
- `.env`, `.git/`, `.githooks/`, `package-lock.json`, `go.sum` dosyalarına
  Edit/Write; `test.md`'ye Write (yalnızca Edit/append izinli) →
  `.claude/hooks/protect-files.sh` (PreToolUse, Edit|Write matcher)

**Yalnızca konvansiyon (hook yok, agent'ın kurala uyması gerekiyor):**
- Rebase edilmeden merge etmeme
- PR'da yalnızca Squash & Merge kullanma
- `main`'e sadece `dev`'den PR ile çıkma
- Anlamlı, küçük commit'ler yapma

**Önemli:** `.claude/hooks/*` katmanı bazı Claude Code sürümlerinde Bash tool
çağrılarını güvenilir şekilde yakalamayabilir (bilinen sınırlama). Asıl duvar
`.githooks/`'tur — git'in kendisi tarafından çalıştırılır, hangi araçla
(Claude Code, Codex, OpenCode, düz terminal) commit/push yapıldığından
bağımsızdır. `.claude/hooks/*` sadece **erken geri bildirim** sağlar, tek
güvence değildir.

## Yardımcı İpuçları

- `git status` her adımda temiz olmalı; yapılmayan iş bırakma.
- Rebase sonrası push reddedilirse yalnızca `git push --force-with-lease` kullan
  (asla `--force`).
- Aynı feature üzerinde uzun süre çalışıyorsan düzenli olarak `git rebase origin/dev` yap.