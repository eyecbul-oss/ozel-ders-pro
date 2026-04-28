#!/usr/bin/env bash
set -e
echo "Ozel Ders Pro APK hazirlaniyor..."
flutter create .
flutter pub get
flutter build apk --release
echo
echo "APK yolu:"
echo "build/app/outputs/flutter-apk/app-release.apk"
