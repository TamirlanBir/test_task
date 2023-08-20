import 'package:hive/hive.dart';

import '../models/login_response_model.dart';

class HiveRepository {
  late final Box<String> _stringsBox;
  late final Box<int> intBox;

  Future<void> init() async {
    registerAdapters();
    _stringsBox = await Hive.openBox<String>(BoxNames.stringBox);
    intBox = await Hive.openBox<int>(BoxNames.intBox);
  }

  void registerAdapters() {}

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _stringsBox.put(BoxKeys.access_token_key, accessToken);
    await _stringsBox.put(BoxKeys.refresh_token_key, refreshToken);
  }

  Tokens getTokens() {
    final accessToken =
        _stringsBox.get(BoxKeys.access_token_key, defaultValue: '')!;
    final refreshToken =
        _stringsBox.get(BoxKeys.refresh_token_key, defaultValue: '')!;
    return Tokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> saveUser(int id, String email, String nickname) async {
    await intBox.put(BoxKeys.user_id, id);
    await _stringsBox.put(BoxKeys.email, email);
    await _stringsBox.put(BoxKeys.nickname, nickname);
  }

  User getUser() {
    final id = intBox.get(BoxKeys.user_id, defaultValue: null)!;
    final email = _stringsBox.get(BoxKeys.email, defaultValue: '')!;
    final nickname = _stringsBox.get(BoxKeys.nickname, defaultValue: '')!;
    return User(email: email, id: id, nickname: nickname);
  }
}

class BoxNames {
  static const String stringBox = 'string_box';
  static const String intBox = 'int_box';
}

class BoxKeys {
  static const String access_token_key = 'access_token_key';
  static const String refresh_token_key = 'refresh_token_key';
  static const String user_id = 'user_id';
  static const String email = 'email';
  static const String nickname = 'nickname';
}
