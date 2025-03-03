import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/i18n/locale_provider.dart' hide Locale;

import '../i18n/translations.g.dart';

class LangSelector extends HookConsumerWidget {
  const LangSelector({
    super.key,
    this.width,
  });

  final double? width;

  @override
  Widget build(context, ref) {
    final currentLocale = ref.watch(localeProvider);

    debugPrint('LangSelector\'s currentLocale: $currentLocale');

    return DropdownMenu<Locale>(
      key: Key(currentLocale.languageTag),
      width: width ?? 60.w,
      initialSelection: currentLocale.flutterLocale,
      dropdownMenuEntries: AppLocaleUtils.supportedLocales
          .map((locale) => DropdownMenuEntry(
                value: locale,
                label: locale.toLanguageTag().toUpperCase(),
                style: ButtonStyle(
                  minimumSize: const WidgetStatePropertyAll(Size.zero),
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h)),
                ),
              ))
          .toList(),
      onSelected: (newLocale) {
        if (newLocale != null) {
          ref.read(localeProvider.notifier).setLocaleRaw(newLocale.toLanguageTag());
        }
      },
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: const UnderlineInputBorder(),
        constraints: BoxConstraints(maxHeight: 40.h),
      ),
      menuStyle: const MenuStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
      ),
    );
  }
}
