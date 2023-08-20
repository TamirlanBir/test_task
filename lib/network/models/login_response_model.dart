import 'dart:convert';

LoginModal loginModalFromJson(String str) =>
    LoginModal.fromJson(json.decode(str));

String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  Tokens tokens;
  User user;

  LoginModal({
    required this.tokens,
    required this.user,
  });

  factory LoginModal.fromJson(Map<String, dynamic> json) => LoginModal(
        tokens: Tokens.fromJson(json["tokens"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "tokens": tokens.toJson(),
        "user": user.toJson(),
      };
}

class Tokens {
  String accessToken;
  String refreshToken;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class User {
  int? id;
  String email;
  String nickname;

  User({
    required this.id,
    required this.email,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nickname": nickname,
      };
}
