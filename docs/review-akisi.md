# Review akışı

Ekip: Murat Can Berber (`m_berber`, repo sorumlusu), Olcay Emre Tok (`e_tok`),
Hasan Gülek (`h_gulek`).

## Gerçek pratik

Review sadece Murat'ta toplanır. Emre ve Hasan **review yapmaz** — yalnızca
güncel `dev`'den açtıkları feature branch'lerden `dev`'e PR açarlar.
`.github/CODEOWNERS` bunu `* @m_berber` ile ifade eder: hangi dosyaya
dokunursa dokunsun, her PR Murat'ın onayını gerektirir.

## Normal PR'lar (Emre veya Hasan açtı)

- Murat review eder ve onaylar.
- Onay sonrası Murat **Squash & Merge** ile birleştirir.

## Murat'ın kendi PR'ı

GitHub kullanıcının kendi PR'ını onaylamasına izin vermez. Kimse başka review
yapmadığı için burada bir "önce başka birine sor" adımı yok — doğrudan
**istisna**:

- Murat kendi PR'ını admin yetkisiyle squash merge eder.
- PR açıklamasına bunun bir istisna olduğu ve neden (kimse review etmiyor,
  bu repoda review tek kişide) yazılır.

## Kim merge eder

Emre/Hasan'ın PR'larını Murat onaylar ve merge eder — yazan kişi asla merge
etmez. Murat'ın kendi PR'ında istisna yukarıdaki gibi işler.
