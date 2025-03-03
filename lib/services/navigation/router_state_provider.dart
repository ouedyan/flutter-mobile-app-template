import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_state_provider.g.dart';

@riverpod
class RouterState extends _$RouterState {
  @override
  GoRouterState? build() => null;

  void setCurrentRouterState(GoRouterState routerState) {
    state = routerState;
    debugPrint('GO ROUTER ----- fullPath: ${state?.fullPath}');
    debugPrint('GO ROUTER ----- uri: ${state?.uri}');
  }
}
