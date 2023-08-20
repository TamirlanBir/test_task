import 'package:dio/dio.dart';
import 'package:test_task/network/models/login_response_model.dart';
import 'package:test_task/network/services/api_const.dart';

class ApiService {
  Future<LoginModal> login(
    String email,
    String password,
  ) async {
    final response =
        await Dio().post('${ApiConst.api}${ApiConst.apiLogIn}', data: {
      'email': email,
      'password': password,
    });
    return LoginModal.fromJson(response.data);
  }
}
