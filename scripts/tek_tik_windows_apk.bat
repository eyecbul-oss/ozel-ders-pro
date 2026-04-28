@echo off
title Ozel Ders Pro APK Builder
echo.
echo ==========================================
echo   Ozel Ders Pro - APK Otomatik Uretici
echo ==========================================
echo.
echo Flutter platform dosyalari kontrol ediliyor...
flutter create .
echo.
echo Paketler yukleniyor...
flutter pub get
echo.
echo APK uretiliyor...
flutter build apk --release
echo.
echo ==========================================
echo APK hazir:
echo build\app\outputs\flutter-apk\app-release.apk
echo ==========================================
pause
