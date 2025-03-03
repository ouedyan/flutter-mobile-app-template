import 'package:flutter/material.dart' as material show showDialog;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobile_template/widgets/scaffold/page_scaffold.dart';

/// You can define consistent UI and behaviors for your Dialogs here
class DialogUtils {
  static Future<T?> showDialog<T>(BuildContext context, WidgetBuilder content) {
    return material.showDialog(
      context: context,
      barrierDismissible: false,
      // Reason for the ScaffoldMessenger/Scaffold/Builder wrapping : Flutter Snack bar showing below Dialog/Bottom Sheet
      // See https://blog.aakashpamnani.in/flutter-snack-bar-on-dialog-ea70a3b5e028
      builder:
          (context) => ScaffoldMessenger(
            child: UnfocusEditableTextsOnTapOutside(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Builder(
                  // Separate contexts
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                        child: content(context),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
    );
  }

  static Future<T?> showDialogOptions<T>(BuildContext context, List<Widget> children) {
    return material.showDialog(context: context, builder: (context) => SimpleDialog(children: children));
  }
}
