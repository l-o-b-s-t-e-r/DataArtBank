class LoginState {
  final String? login;
  final String? password;
  final LoginStatus status;

  const LoginState({
    this.login,
    this.password,
    this.status = const LoginStatusInit(),
  });

  const LoginState.init() : this(status: const LoginStatusInit());

  LoginState copyWith({
    String? login,
    String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      login: login ?? this.login,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          login == other.login &&
          password == other.password &&
          status == other.status;

  @override
  int get hashCode => login.hashCode ^ password.hashCode ^ status.hashCode;
}

sealed class LoginStatus {
  const LoginStatus();

  bool isLoading() => this is LoginStatusLoading;

  bool isSuccess() => this is LoginStatusSuccess;

  bool isFailed() => this is LoginStatusFailed;
}

class LoginStatusInit extends LoginStatus {
  const LoginStatusInit();
}

class LoginStatusLoading extends LoginStatus {}

class LoginStatusFailed extends LoginStatus {
  LoginStatusFailed(this.code);

  final int code;
}

class LoginStatusSuccess extends LoginStatus {}
