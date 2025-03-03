import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/widgets/scaffold/root_scaffold_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/navigation/router_state_provider.dart';

/// A state notifier that manages scaffold configurations for a specific [RootScaffold] type.
///
/// This class maintains a mapping of route paths to their corresponding [RootScaffoldConfig]s,
/// and automatically updates the current configuration when routes change.
class RootScaffoldConfigState<T extends Widget> extends Notifier<RootScaffoldConfig?> {
  final Map<String, RootScaffoldConfig> _registeredConfigs = {};

  @override
  RootScaffoldConfig? build() {
    final currentRoutePath = ref.watch(routerStateProvider.select((state) => state?.fullPath));
    return _registeredConfigs[currentRoutePath];
  }

  void registerConfig(String routePath, RootScaffoldConfig config) {
    _registeredConfigs[routePath] = config;
    // debugPrint("_registeredConfigs: $_registeredConfigs");
    // Notify listeners if the registered config is for the current route
    if (routePath == ref.read(routerStateProvider)?.fullPath) {
      ref.invalidateSelf();
    }
  }

  void unregisterConfig(String routePath) {
    _registeredConfigs.remove(routePath);
    // Notify listeners if the unregistered config was for the current route
    if (routePath == ref.read(routerStateProvider)?.fullPath) {
      ref.invalidateSelf();
    }
  }
}

/// A type alias for the provider that manages root scaffold configurations.
///
/// The type parameter [T] ensures that configurations are isolated between different
/// [RootScaffold] hierarchies.
typedef RootScaffoldConfigProvider<T extends Widget> =
    NotifierProvider<RootScaffoldConfigState<T>, RootScaffoldConfig?>;

/// Global map to store providers for different root scaffold configuration types.
/// This enables type-safe access to different root scaffold configurations (Main, Auth, etc.)
/// while maintaining a single provider instance per type.
final _rootScaffoldConfigProvidersMap = <Type, RootScaffoldConfigProvider>{};

/// Global map to store scaffold keys for different root scaffold types.
/// This enables access to scaffold methods (like opening drawers) from anywhere in the app.
final _rootScaffoldKeysMap = <Type, GlobalKey<ScaffoldState>>{};

/// Retrieves the configuration provider for a specific [RootScaffold] type.
///
/// This function is used by [PageScaffold]s to find their corresponding [RootScaffold]
/// configuration provider. It ensures type safety by only returning providers that
/// match the requested type.
///
/// Throws a [StateError] if no [RootScaffold] of type [T] has been created yet.
RootScaffoldConfigProvider<T>? getRootScaffoldConfigProvider<T extends Widget>() {
  if (T == Widget) {
    return null;
  }
  final provider = _rootScaffoldConfigProvidersMap[T] as RootScaffoldConfigProvider<T>?;
  if (provider == null) {
    throw StateError(
      'No RootScaffold<$T> has been created yet. Make sure you have a RootScaffold<$T> widget in your widget tree before trying to access its configuration.',
    );
  }
  return provider;
}

/// Retrieves the scaffold key for a specific [RootScaffold] type.
///
/// This function is used to access scaffold methods (like opening drawers) from
/// anywhere in the app. It ensures type safety by only returning keys that
/// match the requested type.
///
/// Throws a [StateError] if no [RootScaffold] of type [T] has been created yet.
GlobalKey<ScaffoldState>? getRootScaffoldKey<T extends Widget>() {
  if (T == Widget) {
    return null;
  }
  final key = _rootScaffoldKeysMap[T];
  if (key == null) {
    throw StateError(
      'No RootScaffold<$T> has been created yet. Make sure you have a RootScaffold<$T> widget in your widget tree before trying to access its key.',
    );
  }
  return key;
}

/// Creates a new configuration provider for a specific [RootScaffold] type.
///
/// This function is called by [RootScaffold] when it's first created to set up
/// the necessary state management infrastructure. It ensures that only one provider
/// exists per scaffold type.
///
/// The [scaffoldKey] parameter is stored to enable access to scaffold methods
/// from anywhere in the app.
RootScaffoldConfigProvider<T> createRootScaffoldConfigProvider<T extends Widget>(GlobalKey<ScaffoldState> scaffoldKey) {
  if (T == Widget) {
    throw ArgumentError('The specific root scaffold Widget type must be provided');
  }
  _rootScaffoldConfigProvidersMap[T] = RootScaffoldConfigProvider<T>(RootScaffoldConfigState<T>.new);
  _rootScaffoldKeysMap[T] = scaffoldKey;

  return _rootScaffoldConfigProvidersMap[T] as RootScaffoldConfigProvider<T>;
}
