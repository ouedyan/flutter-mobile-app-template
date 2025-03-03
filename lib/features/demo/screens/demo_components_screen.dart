import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/widgets/scaffold/main_root_scaffold.dart';
import 'package:flutter_mobile_template/widgets/scaffold/page_scaffold.dart';

import '../../../i18n/translations.g.dart';
import '../../../widgets/alerts.dart';
import '../../../widgets/dialogs/utils.dart';
import '../../../widgets/snackbars.dart';

class DemoComponentsScreen extends HookConsumerWidget {
  const DemoComponentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);

    return PageScaffold<MainRootScaffold>(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('UI Components Demo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Snackbars', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            FilledButton(
              onPressed: () {
                SnackBarUtils.showSuccessSnackBar(context, 'This is a success snackbar');
              },
              child: const Text('Show Success Snackbar'),
            ),
            Gap(8.h),
            FilledButton(
              onPressed: () {
                SnackBarUtils.showErrorSnackBar(context, 'This is an error snackbar');
              },
              child: const Text('Show Error Snackbar'),
            ),
            Gap(8.h),

            Gap(24.h),
            Text('Alerts', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            FilledButton(
              onPressed: () {
                AlertUtils.showAlert(
                  context,
                  'This is a regular alert',
                  barrierDismissible: true,
                  actions: [
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
              child: const Text('Show Regular Alert'),
            ),
            Gap(8.h),
            FilledButton(
              onPressed: () {
                AlertUtils.showErrorAlert(
                  context,
                  t.api.system_error_occurred,
                  barrierDismissible: true,
                  actions: [
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
              child: const Text('Show Error Alert'),
            ),
            Gap(24.h),
            Text('Dialogs', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            FilledButton(
              onPressed: () {
                DialogUtils.showDialogOptions<bool>(context, [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(true);
                    },
                    child: const Text('Option 1'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(false);
                    },
                    child: const Text('Option 2'),
                  ),
                ]);
              },
              child: const Text('Show Options Dialog'),
            ),
            Gap(8.h),
            FilledButton(
              onPressed: () {
                DialogUtils.showDialog(
                  context,
                  (context) => SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text('This is a custom dialog'),
                        Gap(0.7.sh),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Show Custom Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
