import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/core/theme/colors.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc/app_bloc_observer.dart';
import 'core/constants.dart';
import 'core/navigation.gr.dart';

Future main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  BlocOverrides.runZoned(
    () {
      // TODO: Dependency Injection
      runApp(
        EasyLocalization(
          supportedLocales: supportedLocales,
          path: translationsPath,
          fallbackLocale: en,
          useOnlyLangCode: true,
          child: MyApp(),
        ),
      );
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  final botToastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Mobile App Template',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [BotToastNavigatorObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      builder: (context, child) {
        ScreenUtil.init(
          context,
          // designSize: const Size(360, 690),
          // minTextAdapt: true,
          // splitScreenMode: true,
        );
        return botToastBuilder.call(context, child);
      },
    );
  }
}
