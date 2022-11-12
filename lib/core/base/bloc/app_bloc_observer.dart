import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    // print("OnCreate Bloc: $bloc");
    super.onCreate(bloc);
  }
}
