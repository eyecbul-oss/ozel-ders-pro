# Özel Ders Pro v2.0.0 - Son Kontrol

Bu paket, Replit videosundaki akışa daha yakınlaştırılmış Flutter kaynak paketidir.

## Son kontrolde düzeltilenler
- Türkçe karakterler UTF-8 olarak korundu.
- Uygulama adı: Özel Ders Pro.
- Splash ekranı: Özel Ders Pro / by SezR.
- Geliştirici bilgileri Ayarlar ekranına eklendi.
- Öğrenci kartlarında WhatsApp ve Detay butonları var.
- Öğrenci detayında WhatsApp, ders ekle ve sil alanı var.
- Pano ana menü kartları Replit videosuna yaklaştırıldı.
- Dersler ekranında Liste / Hafta sekmesi var.
- Bugünkü Dersler, Bakiyeler, Raporlar, Ayarlar ekranları var.
- Yazı taşmalarına karşı uzun para ve isim alanlarında FittedBox / ellipsis kullanıldı.
- WhatsApp için AndroidManifest queries alanı eklendi.

## Önemli
Bu paket tam Flutter proje kaynaklarıdır. Bilgisayarda APK üretmeden önce klasörde platform dosyaları eksikse şu komutu çalıştır:

```bash
flutter create .
flutter pub get
flutter run
```

APK üretmek için:

```bash
flutter build apk --release
```

APK çıktı yolu:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Geliştirici
Sezer Bulut  
(505) 826 69 49  
sezerbulut@hotmail.com  
by SezR


---

# Full Otomatik APK Sistemi

Bu pakette otomatik APK üretim sistemi hazırdır.

Windows:
```text
scripts/tek_tik_windows_apk.bat
```

GitHub otomatik build:
```text
.github/workflows/build-apk.yml
```

Detaylı anlatım:
```text
APK_OTOMATIK_SISTEM.md
scripts/githuba_yukle_ve_apk_al.md
```
