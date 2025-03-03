import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobile_template/services/navigation/router.dart';
import 'package:flutter_mobile_template/services/storage/prefs.dart';
import 'package:flutter_mobile_template/services/storage/secure_storage.dart';
import 'package:flutter_mobile_template/theme/app_theme.dart';
import 'package:flutter_mobile_template/utils/providers/provider_observer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

import 'i18n/locale_provider.dart';
import 'i18n/translations.g.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the native splash screen until manual removal
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // See https://docs.flutter.dev/cookbook/design/orientation#locking-device-orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  HttpOverrides.global = CustomHttpOverrides(
    allowBadCertificates: true,
    trustedHosts: ['localhost', 'trustedexample.api'],
  );

  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: TranslationProvider(child: const _EagerInitialization(child: App())),
    ),
  );
}

class _EagerInitialization extends HookConsumerWidget {
  const _EagerInitialization({required this.child});

  final Widget child;

  @override
  Widget build(context, ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    // See https://riverpod.dev/docs/essentials/eager_initialization
    final prefs = ref.watch(prefsProvider);
    final secureStorage = ref.watch(secureStorageProvider);

    final providersReady = prefs.hasValue && secureStorage.hasValue;
    final i18nReady = useState(false);

    useEffect(() {
      if (prefs.hasValue) {
        // Init I18n
        ref.read(localeProvider.notifier).initLocale();
        i18nReady.value = true;
      }
      return null;
    }, [prefs]);

    if (prefs.hasError || secureStorage.hasError) {
      // Return InitializationError page with retry options
    }

    if (providersReady && i18nReady.value) return child;

    return const SizedBox();
  }
}

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(context, ref) {
    final router = ref.watch(routerProvider);

    useEffect(() {
      FlutterNativeSplash.remove();
      return;
    }, []);

    final defaultTheme = ThemeData.light();

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp.router(
          title: 'Flutter Mobile Template',
          theme: defaultTheme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(defaultTheme.textTheme),
            filledButtonTheme: FilledButtonThemeData(style: AppTheme.light().button),
            outlinedButtonTheme: OutlinedButtonThemeData(style: AppTheme.light().button),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.purple,
              error: AppColors.red,
              dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
            ),
            extensions: [AppTheme.light()],
          ),
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            ...GlobalMaterialLocalizations.delegates,
            // form_builder_validators error messages i18n (auto language detection...etc)
            FormBuilderLocalizations.delegate,
            // Phone form field Dynamic localization
            ...PhoneFieldLocalization.delegates,
          ],
          routerConfig: router,
          builder: (context, child) {
            final localizedErrorMessages = FormBuilderLocalizations.of(context);

            return ReactiveFormConfig(
              validationMessages: {
                ValidationMessage.required: (error) => localizedErrorMessages.requiredErrorText,
                ValidationMessage.email: (error) => localizedErrorMessages.emailErrorText,
                ...PhoneValidationMessage.localizedValidationMessages(context),
              },
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class CustomHttpOverrides extends HttpOverrides {
  final bool allowBadCertificates;
  final List<String> trustedHosts;

  CustomHttpOverrides({this.allowBadCertificates = false, this.trustedHosts = const []});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (kReleaseMode) {
          // Never allow bad certificates in release mode
          return false;
        }

        if (allowBadCertificates && trustedHosts.contains(host)) {
          debugPrint('WARNING: Accepting bad certificate for $host:$port');
          return true;
        }

        return false;
      };
  }
}
