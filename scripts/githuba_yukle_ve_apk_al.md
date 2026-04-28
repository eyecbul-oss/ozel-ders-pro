# Otomatik APK Sistemi

Bu projede APK otomatik üretimi için GitHub Actions hazırlandı.

## 1) GitHub'da yeni repository aç
- GitHub'a gir
- New repository
- İsim: `ozel-ders-pro`
- Public veya Private seçebilirsin
- Create repository

## 2) Bu proje klasörünü GitHub'a yükle

Bilgisayarda proje klasörünün içinde terminal aç:

```bash
git init
git add .
git commit -m "Ozel Ders Pro ilk otomatik APK sistemi"
git branch -M main
git remote add origin GITHUB_REPO_LINKINI_BURAYA_YAZ
git push -u origin main
```

## 3) APK otomatik oluşur

GitHub'da:
- Repository sayfasına gir
- Actions sekmesine gir
- Build Android APK çalışmasını aç
- İşlem bitince en altta `Ozel-Ders-Pro-APK` dosyasını indir

## 4) APK dosyası

İndirdiğin ZIP'in içinde:

```text
app-release.apk
```

olacak.
