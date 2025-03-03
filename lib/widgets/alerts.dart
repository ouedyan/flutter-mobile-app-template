import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../i18n/translations.g.dart';

/// You can define consistent UI and behaviors for your Alerts here
class AlertUtils {
  static Future<T?> showAlert<T>(BuildContext context, String message,
      {List<Widget>? actions, bool barrierDismissible = false}) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: actions,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<T?> showErrorAlert<T>(BuildContext context, String message,
      {List<Widget>? actions, bool barrierDismissible = false}) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          message,
          style: TextStyle(color: context.theme.colorScheme.error),
        ),
        actions: actions,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future handleError(BuildContext context, Object error,
      {List<Widget>? actions, bool barrierDismissible = false}) {
    final t = Translations.of(context);
    // Set your custom localized error message handing here. Eg:
    // if (error is DioException) {
    //   final errorMessage = getLocalizedErrorFromDioBaseResponse(error, t);
    //   return showErrorAlert(context, errorMessage, actions: actions, barrierDismissible: barrierDismissible);
    // }
    return showErrorAlert(context, t.api.system_error_occurred,
        actions: actions, barrierDismissible: barrierDismissible);
  }
}
