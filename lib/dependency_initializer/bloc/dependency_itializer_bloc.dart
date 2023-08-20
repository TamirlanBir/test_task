import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'dependency_itializer_event.dart';
part 'dependency_itializer_state.dart';

class DependencyItializerBloc
    extends Bloc<DependencyItializerEvent, DependencyItializerState> {
  DependencyItializerBloc() : super(NotInitializedDependencyItializer()) {
    on<InitialDependencyItializedEvent>(
        (event, emit) => _onInitialDependencyItializedEvent(event, emit));
  }
  _onInitialDependencyItializedEvent(InitialDependencyItializedEvent event,
      Emitter<DependencyItializerState> emit) async {
    await event._initializer.call(event.context);
    emit(InitializedDependencyItializer());
  }
}
