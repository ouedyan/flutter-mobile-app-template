// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'2d64bd2f170478a6e6de516dc4479f13bb3dd66c';

/// Provides the application's routing configuration using [GoRouter].
///
/// The router configuration includes:
/// - Integration with [PopNotifier] to handle navigation state refresh after pop events
/// - Route destinations wrapped with [RoutePage] for consistent behavior
///
/// Usage:
/// ```dart
/// final router = ref.watch(routerProvider);
/// ```
///
/// See also:
///  * [RoutePage] - The wrapper widget used for all route destinations
///  * [PopNotifier] - Handles navigation state refresh
///
/// Copied from [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
