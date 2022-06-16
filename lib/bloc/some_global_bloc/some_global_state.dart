part of 'some_global_bloc.dart';

abstract class SomeGlobalState extends Equatable {
  const SomeGlobalState();
}

class SomeGlobalInitial extends SomeGlobalState {
  @override
  List<Object> get props => [];
}
