part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class SignInInital extends AuthState {}

class StateAuthLoading extends AuthState {}

class StateSuccessSignIn extends AuthState {
  final String accessToken;
  StateSuccessSignIn({required this.accessToken});
}

class StateErrorSignIn extends AuthState {
  final String errorMessage;
  StateErrorSignIn(this.errorMessage);
}
