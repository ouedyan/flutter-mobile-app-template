import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      print('OnCreate Bloc: ' + bloc.toString());
    }
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('Bloc Error: $error Bloc: $bloc');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      print('Bloc Event: $event Bloc: $bloc');
    }
    super.onEvent(bloc, event);
  }
}
