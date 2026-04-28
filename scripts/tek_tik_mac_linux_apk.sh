#!/usr/bin/env bash
set -e
echo "=========================================="
echo "  Ozel Ders Pro - APK Otomatik Uretici"
echo "=========================================="
flutter create .
flutter pub get
flutter build apk --release
echo "APK hazir:"
echo "build/app/outputs/flutter-apk/app-release.apk"
