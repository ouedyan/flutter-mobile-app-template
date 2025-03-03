import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/services/navigation/router_state_provider.dart';
import 'package:flutter_mobile_template/widgets/scaffold/main_root_scaffold.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/demo/screens/demo_components_screen.dart';
import '../../features/demo/screens/demo_i18n_screen.dart';
import '../../features/demo/screens/demo_infinite_provider_screen.dart';
import '../../features/demo/screens/demo_infinite_query_screen.dart';
import '../../features/demo/screens/demo_mutations_screen.dart';
import '../../features/demo/screens/demo_navigation_screen.dart';
import '../../features/demo/screens/demo_query_screen.dart';
import '../../features/home/screens/home_screen.dart';
import 'pop_notifier.dart';
import 'route_page.dart';

part 'router.g.dart';

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
@riverpod
GoRouter router(Ref ref) {
  final popNotifier = ref.read(popNotifierProvider);

  final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    refreshListenable: Listenable.merge([
      // Fix for pop ignoring some GoRouter state refresh like redirect
      // See https://github.com/flutter/flutter/issues/110149
      popNotifier,
      // ...add other listenables here like your authStateNotifier,
    ]),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainRootScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: '/', builder: (context, state) => RoutePage(child: const HomeScreen()))],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/demo',
                builder: (context, state) => RoutePage(child: const DemoNavigationScreen()),
                routes: [
                  GoRoute(
                    path: 'components',
                    builder: (context, state) => RoutePage(child: const DemoComponentsScreen()),
                  ),
                  GoRoute(path: 'i18n', builder: (context, state) => RoutePage(child: const DemoI18nScreen())),
                  GoRoute(path: 'query', builder: (context, state) => RoutePage(child: const DemoQueryScreen())),
                  GoRoute(
                    path: 'infinite-query',
                    builder: (context, state) => RoutePage(child: const DemoInfiniteQueryScreen()),
                  ),
                  GoRoute(
                    path: 'infinite-provider',
                    builder: (context, state) => RoutePage(child: const DemoInfiniteProviderScreen()),
                  ),
                  GoRoute(
                    path: 'mutations',
                    builder: (context, state) => RoutePage(child: const DemoMutationsScreen()),
                  ),
                ],
              ),
            ],
          ),
          // Other branches (for eg for bottom navigation)
        ],
      ),

      // Other routing hierarchies (Eg: auth shell hierarchy with AuthScaffold...etc )
    ],
    redirect: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(routerStateProvider.notifier).setCurrentRouterState(state);
      });

      // Your global redirect logic here (eg: First entry, auth..etc)

      return null;
    },
  );

  ref.onDispose(router.dispose);
  return router;
}
