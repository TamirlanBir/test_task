part of 'dependency_itializer_bloc.dart';

@immutable
abstract class DependencyItializerEvent {}

class InitialDependencyItializedEvent extends DependencyItializerEvent {
  final Future<bool> Function(BuildContext context) _initializer;
  final BuildContext context;
  InitialDependencyItializedEvent(this._initializer, this.context);
}
