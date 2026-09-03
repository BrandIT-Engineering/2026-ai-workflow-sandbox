# Worktree akışı

ThingWorx'ta tek bir ortak sunucuya bağlanıp orada geliştirme yapmaya alışkınsan,
git worktree ilk bakışta tuhaf gelebilir. Kısa özet: **`dev` senin makinende bir
klasör değil, bir fotoğraf.** O fotoğrafı istediğin kadar çoğaltıp her kopyada
ayrı bir iş yapabilirsin — biri bozulursa diğerlerine dokunmaz.

Her worktree = kendi klasörü + kendi branch'i + kendi Claude Desktop session'ı.
Aynı anda 3 farklı işin üzerinde çalışman gerekiyorsa, 3 worktree açarsın; hangi
klasördeysen o iş odasındasın, branch değiştirip başkasının işine karışmazsın.

## Bir görevin tam yaşam döngüsü

```bash
# 1. Yeni iş: worktree + branch bir arada açılır
git start giris-formu
# çıktı: /Users/sen/kod/2026-ai-workflow-sandbox-giris-formu

# 2. O klasöre geç, çalış, commit et
cd /Users/sen/kod/2026-ai-workflow-sandbox-giris-formu
git add .
git commit -m "feat(giris): validasyon eklendi"

# 3. dev'i kendine çek, temizce rebase et, güvenli push
git sync

# 4. PR aç (dev'e), review sonrası squash & merge
gh pr create --base dev

# 5. Merge sonrası worktree'yi kapat
cd ..
git worktree remove 2026-ai-workflow-sandbox-giris-formu
```

`git start`, `git sync` ve `git wl` (worktree list) kısayolları `scripts/setup-dev.sh`
ile bir kere kurulur — bkz. proje kökündeki kurulum talimatı.

## Claude Desktop'ta worktree açma

1. `git start <isim>` çalıştır, çıkan klasör yolunu kopyala.
2. Claude Desktop'ta **Project** seçiminden **Open Project** / klasör simgesine tıkla.
3. Kopyaladığın worktree klasörünü seç — repo kökünü değil, `-<isim>` ekli olanı.
4. Yeni bir Claude Code session'ı bu klasörde başlar; `git branch --show-current`
   ile doğru branch'te olduğunu doğrula.
5. İş bitince o session'ı kapat, klasörü sil (`git worktree remove`).

Her worktree ayrı bir Claude Desktop project'i gibi düşünülmeli — iki işi aynı
klasörde açık tutmaya çalışma.

## Sık hatalar

| Belirti | Sebep | Çözüm |
|---|---|---|
| "Yanlış klasörde açtım, değişikliklerim başka branch'e gitti" | Repo kökünü açtın, worktree'yi değil | Doğru worktree klasörünü aç; kökte hiç çalışma yapma |
| "Worktree'yi sildim ama branch hâlâ duruyor" | `rm -rf` ile klasörü sildin, git'e haber vermedin | `git worktree remove <yol>` kullan; zaten silinmişse `git worktree prune` |
| "İki worktree aynı branch'i istiyor" hatası | Aynı branch iki worktree'de checkout edilemez | Farklı bir isimle yeni branch aç (`git start` her zaman yeni isim ister) |
| `git sync` conflict veriyor | Uzun süre `dev`'den kopuk çalışıldı | Conflict'i çöz, `git rebase --continue`, sonra `git push --force-with-lease` |
