import 'package:data_art_bank/models/login_state.dart';

class AppState {
  final LoginState loginState;

  AppState({this.loginState = const LoginState.init()});

  factory AppState.init() => AppState(
        loginState: const LoginState.init(),
      );

  AppState copyWith({LoginState? loginState}) {
    return AppState(
      loginState: loginState ?? this.loginState,
    );
  }

  @override
  int get hashCode => loginState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          loginState == other.loginState;
}
