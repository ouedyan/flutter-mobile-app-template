import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../view/home/home_view.dart';

final GlobalKey<NavigatorState> mainNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'main');

final routes = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomeView();
      },
    ),
  ],
);
