class LoginResponse {
  late final String token;
  late final String tokenType;

  LoginResponse({
    required this.token,
    required this.tokenType,
  });

  static LoginResponse fromMap({required Map map}) => LoginResponse(
        token: map['token'],
        tokenType: map['tokenType'],
      );
}
