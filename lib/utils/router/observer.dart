import 'package:flutter/widgets.dart';

// Doesn't work when passed to GoRouter globally,
// ShellRoutes seem to cause NavigatorObserver to not fire
// Need to pass the same observer again to each shell branch.
// (Even that maybe has not firing issues with stateful shell routes)
// https://github.com/flutter/flutter/issues/112196
class NavigationObserver extends NavigatorObserver {
  final void Function(String) onRouteChanged;

  NavigationObserver(this.onRouteChanged);

  @override
  void didPush(route, previousRoute) {
    onRouteChanged(route.settings.name ?? '');
    debugPrint('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didPop(route, previousRoute) {
    onRouteChanged(previousRoute?.settings.name ?? '');
    debugPrint('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didRemove(route, previousRoute) {
    onRouteChanged(previousRoute?.settings.name ?? '');
    debugPrint('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didReplace({newRoute, oldRoute}) {
    onRouteChanged(newRoute?.settings.name ?? '');
    debugPrint('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');
  }

  @override
  void didStartUserGesture(
    route,
    previousRoute,
  ) {
    debugPrint('didStartUserGesture: ${route.str}, '
        'previousRoute= ${previousRoute?.str}');
  }

  @override
  void didStopUserGesture() {
    debugPrint('didStopUserGesture');
  }
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
