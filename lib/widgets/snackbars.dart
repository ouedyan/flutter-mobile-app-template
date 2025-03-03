import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../i18n/translations.g.dart';

/// You can define consistent UI and behaviors for your SnackBars here
class SnackBarUtils {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message, style: TextStyle(color: context.theme.colorScheme.error))));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> handleError(
    BuildContext context,
    Object error, {
    List<Widget>? actions,
    bool barrierDismissible = false,
  }) {
    final t = Translations.of(context);
    // Set your custom localized error message handing here. Eg:
    // if (error is DioException) {
    //   final errorMessage = getLocalizedErrorFromDioBaseResponse(error, t);
    //   return showErrorSnackBar(context, errorMessage);
    // }
    return showErrorSnackBar(context, t.api.system_error_occurred);
  }
}
