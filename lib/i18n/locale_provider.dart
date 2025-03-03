import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/i18n/translations.g.dart';
import 'package:flutter_mobile_template/services/storage/prefs.dart';
import 'package:flutter_mobile_template/utils/strings/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class Locale extends _$Locale {
  @override
  AppLocale build() {
    ref.keepAlive();

    _listenToLocaleChanges();
    return LocaleSettings.currentLocale;
  }

  void _listenToLocaleChanges() {
    LocaleSettings.getLocaleStream().listen((locale) {
      state = locale;
      debugPrint('Locale changed: $locale');
    });
  }

  void initLocale() {
    final localePref = ref.read(prefsProvider).requireValue.getString('locale');
    final storedRawLocale = (!localePref.isNullOrEmpty) ? localePref : null;
    debugPrint('storedRawLocale: $storedRawLocale');
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (storedRawLocale != null) {
        LocaleSettings.setLocaleRaw(storedRawLocale);
      } else {
        LocaleSettings.useDeviceLocale();
      }
    });
  }

  void setLocale(AppLocale newLocale) {
    LocaleSettings.setLocale(newLocale);
    ref.read(prefsProvider).requireValue.setString('locale', newLocale.flutterLocale.toLanguageTag());
  }

  void setLocaleRaw(String newLocale) {
    LocaleSettings.setLocaleRaw(newLocale);
    ref.read(prefsProvider).requireValue.setString('locale', newLocale);
  }
}
