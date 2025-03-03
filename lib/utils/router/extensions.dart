import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension RouterStringUtils on String {
  String appendQueryAndFragment(Uri uri) {
    return this + (uri.hasQuery ? '?${uri.query}' : '') + (uri.hasFragment ? '#${uri.fragment}' : '');
  }

  String appendCurrentLocationQueryAndFragment(BuildContext context) {
    final routerState = GoRouterState.of(context);
    return this +
        (routerState.uri.hasQuery ? '?${routerState.uri.query}' : '') +
        (routerState.uri.hasFragment ? '#${routerState.uri.fragment}' : '');
  }
}
