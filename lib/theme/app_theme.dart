import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_theme.tailor.dart';

@TailorMixin()
class AppTheme extends ThemeExtension<AppTheme> with _$AppThemeTailorMixin {
  const AppTheme({
    required this.primaryColor,
    required this.errorColor,
    required this.h1,
    required this.button,
    required this.smallButton,
    required this.link,
  });

  @override
  final Color primaryColor;
  @override
  final Color errorColor;
  @override
  final TextStyle h1;
  @override
  final ButtonStyle button;
  @override
  final ButtonStyle smallButton;
  @override
  final TextStyle link;

  // Is a function because of responsive values (sp...etc)
  static AppTheme light() => AppTheme(
      primaryColor: AppColors.purple,
      errorColor: AppColors.red,
      h1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24.sp,
        color: AppColors.purple,
      ),
      button: ButtonStyle(
        iconSize: WidgetStateProperty.all(24),
        textStyle: WidgetStateProperty.all(TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
        )),
      ),
      smallButton: ButtonStyle(
        iconSize: WidgetStateProperty.all(14),
        textStyle: WidgetStateProperty.all(TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        )),
      ),
      link: const TextStyle(
        color: AppColors.purple,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.purple,
      ));
}

abstract class AppColors {
  static const purple = Colors.deepPurple;
  static const red = Colors.red;
}

abstract class AppGradients {
  static const purpleToRed = LinearGradient(
    colors: [AppColors.purple, AppColors.red],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
