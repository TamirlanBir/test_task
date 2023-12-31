import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/repository/hive_repository.dart';

part 'dynamic_link_layer_event.dart';

part 'dynamic_link_layer_state.dart';

class DynamicLinkLayerBloc
    extends Bloc<DynamicLinkLayerEvent, DynamicLinkLayerState> {
  bool isAuthorized;
  final HiveRepository _hiveRepository;

  DynamicLinkLayerBloc(this._hiveRepository, this.isAuthorized)
      : super(DynamicLinkLayerInitial()) {
    on<InitialDynamicLinkLayerEvent>(
        (event, emit) => _buildInitialEvent(event, emit));
  }

  _buildInitialEvent(InitialDynamicLinkLayerEvent event,
      Emitter<DynamicLinkLayerState> emit) async {
    if (isAuthorized) {
      emit(AuthorizedState());
    } else {
      emit(NotAuthorizedState());
    }
  }
}
