import 'dart:io';

import 'package:data_art_bank/actions/login_actions.dart';
import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/repositories/auth_repository.dart';
import 'package:redux/redux.dart';

class AuthMiddleware {
  AuthMiddleware({required this.repository});

  final AuthRepository repository;

  List<Middleware<AppState>> create() {
    return [
      TypedMiddleware<AppState, LoginAction>(_login),
    ];
  }

  void _login(
    Store<AppState> store,
    LoginAction action,
    NextDispatcher next,
  ) async {
    store.dispatch(LoginLoadingAction());
    try {
      await repository.login(action.login, action.password);
      store.dispatch(LoginSuccessAction());
    } catch (e) {
      store.dispatch(LoginFailedAction(code: HttpStatus.serviceUnavailable));
    }
  }
}
