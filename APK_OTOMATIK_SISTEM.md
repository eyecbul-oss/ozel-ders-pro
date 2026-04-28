# Özel Ders Pro - Full Otomatik APK Sistemi

Bu sürümde APK üretmek için 3 yol hazırlandı.

## Yol 1: GitHub Actions ile otomatik APK

Projeyi GitHub'a yükleyince APK otomatik üretilir.

Hazır dosya:

```text
.github/workflows/build-apk.yml
```

GitHub'da Actions sekmesine girip `Ozel-Ders-Pro-APK` çıktısını indir.

## Yol 2: Windows tek tık APK

Dosyayı çalıştır:

```text
scripts/tek_tik_windows_apk.bat
```

## Yol 3: Mac / Linux tek komut

```bash
chmod +x scripts/tek_tik_mac_linux_apk.sh
./scripts/tek_tik_mac_linux_apk.sh
```

## APK çıktısı

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Geliştirici

Sezer Bulut  
(505) 826 69 49  
sezerbulut@hotmail.com  
by SezR
