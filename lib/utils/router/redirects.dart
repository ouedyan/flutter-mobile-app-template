import 'package:go_router/go_router.dart';
import 'package:flutter_mobile_template/utils/router/extensions.dart';

/// Creates a redirect function that automatically navigates to a child route when the parent route is matched exactly.
///
/// [initialChildLocation] is the path segment of the child route to redirect to.
///
/// This is useful for routes that should never display their parent route directly,
/// but instead always show a specific child route. For example:
///
/// ```dart
/// GoRoute(
///   path: '/settings',
///   redirect: initialChild('general'),
///   routes: [
///     GoRoute(path: 'general', builder: ...),
///     GoRoute(path: 'profile', builder: ...),
///     GoRoute(path: 'notifications', builder: ...),
///   ],
/// )
/// ```
///
/// In this case, navigating to '/settings' will automatically redirect to
/// '/settings/general' while preserving any query parameters and fragments.
GoRouterRedirect initialChild(String initialChildLocation) {
  return (context, state) => state.matchedLocation == state.uri.path
      ? '${state.matchedLocation}/$initialChildLocation'
          .appendQueryAndFragment(state.uri)
      : null;
}
