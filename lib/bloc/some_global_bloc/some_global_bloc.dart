import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'some_global_event.dart';
part 'some_global_state.dart';

class SomeGlobalBloc extends Bloc<SomeGlobalEvent, SomeGlobalState> {
  SomeGlobalBloc() : super(SomeGlobalInitial()) {
    on<SomeGlobalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
