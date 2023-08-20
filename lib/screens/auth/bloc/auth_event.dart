part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class EventAuthInit extends AuthEvent {}

class EventLogOut extends AuthEvent {}

class EventAuthEmail extends AuthEvent {
  final String email;
  final String password;
  EventAuthEmail(this.email, this.password);
}
