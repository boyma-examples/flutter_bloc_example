class LoginModel {
  final String login;
  final String password;

  LoginModel({
    required this.login,
    required this.password,
  });

  LoginModel copyWith({
    String? login,
    String? password,
  }) {
    return LoginModel(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }
}
