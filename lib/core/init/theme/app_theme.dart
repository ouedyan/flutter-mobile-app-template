import 'package:flutter/material.dart';

class AppTheme {
  static AppTheme? _instance;
  static AppTheme get instance {
    if (_instance != null) return _instance!;
    _instance = AppTheme._init();
    return _instance!;
  }

  AppTheme._init();

  ThemeData appTheme = ThemeData.dark();
}
