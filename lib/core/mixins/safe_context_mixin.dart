import 'package:flutter/material.dart';

mixin SafeContextMixin<T extends StatefulWidget> on State<T> {
  void safeOperation(VoidCallback function) {
    if (!mounted) return;
    function.call();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }
}
