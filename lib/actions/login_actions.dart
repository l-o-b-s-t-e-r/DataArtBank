class LoginAction {
  LoginAction({
    required this.login,
    required this.password,
  });

  String login;
  String password;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginAction &&
          runtimeType == other.runtimeType &&
          login == other.login &&
          password == other.password;

  @override
  int get hashCode => login.hashCode ^ password.hashCode;
}

class LoginLoadingAction {}

class LoginSuccessAction {}

class LoginFailedAction {
  LoginFailedAction({required this.code});

  final int code;
}
