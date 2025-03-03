import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pop_notifier.dart';

/// A wrapper widget for route destinations that provides consistent navigation behavior and fixes.
///
/// This widget serves several key purposes:
///
/// 1. **Consistent Route Wrapping**
///    - Provides a standardized container for all route destinations
///    - Creates a single point of modification for page-level behaviors
///    - Can be used to implement consistent page transitions (see [GoRoute.pageBuilder])
///
/// 2. **Navigation State Management**
///    - Fixes an issue where GoRouter doesn't properly refresh state after pop events
///      (see https://github.com/flutter/flutter/issues/110149)
///    - Uses [PopScope] to detect pop events and [PopNotifier] to trigger state refresh
///    - Implements post-frame callbacks to avoid blocking the current pop operation
///
/// 3. **Extensibility**
///    - Serves as a central place for implementing custom page transitions
///      (see https://github.com/flutter/flutter/issues/113282)
///    - Allows adding consistent behaviors across routes (analytics, permissions, etc.)
///
/// Usage:
/// ```dart
/// GoRoute(
///   path: '/some-path',
///   builder: (context, state) => RoutePage(
///     child: YourScreen(),
///   ),
/// )
/// ```
///
/// See also:
///  * [PopNotifier] - The notifier used to trigger navigation state refresh
///  * [GoRouter] - The routing package this widget is designed to work with
class RoutePage extends ConsumerWidget {
  final Widget child;

  const RoutePage({super.key, required this.child});

  @override
  Widget build(context, ref) {
    // Wrap with your custom page transition for GoRoute.pageBuilder if needed for all pages
    // See: https://github.com/flutter/flutter/issues/113282

    // Part of a fix for pop ignoring some GoRouter state refresh like redirect
    // See https://github.com/flutter/flutter/issues/110149
    return PopScope<Object?>(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        print("PopScope onPopInvokedWithResult, didPop: $didPop, result: $result");

        if (didPop) {
          // Without addPostFrameCallback, refreshes navigation too quickly thus blocking the current pop
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(popNotifierProvider).notifyPop();
          });
        }
      },
      child: child,
    );
  }
}
