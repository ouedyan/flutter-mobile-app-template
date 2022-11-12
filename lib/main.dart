import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mobile_template/core/init/routes/routes.dart';
import 'package:flutter_mobile_template/core/init/theme/colors.dart';
import 'package:flutter_mobile_template/view/home/home_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'core/base/bloc/app_bloc_observer.dart';
import 'core/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('tr');
  await EasyLocalization.ensureInitialized();

  runZoned(
    () => runApp(
      MultiRepositoryProvider(
        providers: DependencyInjector.instance.repositoryProviders,
        child: MultiBlocProvider(
          providers: DependencyInjector.instance.globalBlocProviders,
          child: const MyApp(),
        ),
      ),
    ),
  );
  Bloc.observer = AppBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return Sizer(
      builder: (context, orientation, deviceType) {
        final botToastBuilder = BotToastInit();
        return MaterialApp.router(
          routerConfig: routes,
          builder: (context, child) => botToastBuilder(
            context,
            const HomeView(),
          ),
          title: 'Flutter Mobile App Template',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: primarySwatch,
          ),
        );
      },
    );
  }
}
