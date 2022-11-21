import 'package:flutter/cupertino.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension DoubleExtension on double {
  String get toShortDoubleNumber =>
      "${toString().split(".").first}.${toString().split(".")[1].substring(0, 2)}";
}
