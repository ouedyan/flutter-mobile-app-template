import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pop_notifier.g.dart';

/// A [ChangeNotifier] that helps manage navigation state refresh after pop events.
///
/// This notifier is part of a solution to address a Flutter issue where [GoRouter]
/// doesn't properly refresh its state after pop navigation events. When integrated with
/// [GoRouter.refreshListenable], it ensures that the router's state is properly
/// updated after back navigation.
///
/// The issue it addresses:
/// When using GoRouter's redirect functionality, popping a route sometimes doesn't
/// trigger the expected state refresh, which can lead to incorrect navigation state.
/// See: https://github.com/flutter/flutter/issues/110149
///
/// Usage:
/// 1. Create a provider instance of this notifier
/// 2. Add it to [GoRouter.refreshListenable]
/// 3. Call [notifyPop] when pop events occur (typically via [RoutePage])
///
/// Example:
/// ```dart
/// final router = GoRouter(
///   refreshListenable: popNotifier, // Add to router's refresh listeners
///   // ... other router configuration
/// );
/// ```
///
/// See also:
///  * [RoutePage] - The widget that uses this notifier to handle pop events
///  * [GoRouter] - The routing package this notifier is designed to work with
class PopNotifier extends ChangeNotifier {
  void notifyPop() {
    notifyListeners();
  }
}

@riverpod
// ignore: unsupported_provider_value
PopNotifier popNotifier(Ref ref) {
  ref.keepAlive();
  final notifier = PopNotifier();
  ref.onDispose(notifier.dispose);
  return notifier;
}
