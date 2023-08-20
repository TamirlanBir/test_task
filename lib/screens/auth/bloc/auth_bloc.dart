import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/network/models/login_response_model.dart';
import 'package:test_task/network/repository/hive_repository.dart';

import '../../../network/services/api_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.hiverepository,
  }) : super(SignInInital()) {
    on<EventAuthInit>((event, emit) => emit(SignInInital()));
    on<EventAuthEmail>(((event, emit) async {
      try {
        emit(StateAuthLoading());

        LoginModal token =
            await ApiService().login(event.email, event.password);

        await hiverepository?.saveUser(
            token.user.id!, token.user.email, token.user.nickname);

        emit(StateSuccessSignIn(accessToken: token.tokens.accessToken));
      } catch (e) {
        print(e);
        emit(StateErrorSignIn('Что то пошло не так'));
      }
    }));
  }
  HiveRepository? hiverepository;
}
