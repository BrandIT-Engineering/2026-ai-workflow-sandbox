# Review akışı

Ekip: Murat Can Berber (`m_berber`, repo sorumlusu), Olcay Emre Tok (`e_tok`),
Hasan Gülek (`h_gulek`).

## Normal PR'lar

`.github/CODEOWNERS`'daki kritik yollara dokunmayan her PR için:

- Emre ↔ Hasan çapraz review yapar (biri açarsa diğeri onaylar).
- En az **1 onay** yeterli.
- Merge yöntemi her zaman **Squash & Merge**.

## CODEOWNERS'a düşen PR'lar

`.github/`, `.githooks/`, `.claude/`, `AGENTS.md`, `CLAUDE.md`, `scripts/`
yollarından herhangi birine dokunan PR'larda **Murat'ın onayı zorunludur** —
GitHub bunu CODEOWNERS üzerinden otomatik ister.

## Murat'ın kendi PR'ı

GitHub kullanıcının kendi PR'ını onaylamasına izin vermez, dolayısıyla bu
durum ayrı ele alınır:

1. Önce en yakın uygun kişi (Emre veya Hasan) review eder ve onaylar — normal
   akış budur, tercih edilen yoldur.
2. Kimse uygun değilse (herkes meşgul/izinli, iş acil) Murat kendi PR'ını
   admin yetkisiyle squash merge eder. Bu bir **istisnadır**, "normal review"
   sayılmaz. PR açıklamasına neden bu yola gidildiği yazılır (örn. "Emre ve
   Hasan izinli, X saat bekleyemez").

## Kim merge eder

Merge işlemini **yazan kişi değil, onaylayan kişi** yapar. Murat kendi
PR'ını yazdıysa ve Emre onayladıysa, merge'ü Emre yapar — istisna durumu
(yukarıdaki madde 2) hariç.
