import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../view/home/home_view.dart';

final GlobalKey<NavigatorState> mainNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'main');

animationPage({required GoRouterState state, required Widget route}) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: route,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        ),
        child: child,
      ),
    );

final routes = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return animationPage(
          state: state,
          route: const HomeView(),
        );
      },
    ),
  ],
);
