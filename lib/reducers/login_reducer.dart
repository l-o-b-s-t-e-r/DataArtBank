import 'package:data_art_bank/actions/login_actions.dart';
import 'package:data_art_bank/models/states/login_state.dart';
import 'package:redux/redux.dart';

class LoginReducer {
  static final reduce = combineReducers<LoginState>([
    TypedReducer<LoginState, LoginAction>(
      (state, action) => state.copyWith(
        login: action.login,
        password: action.password,
      ),
    ),
    TypedReducer<LoginState, LoginLoadingAction>(
      (state, _) => state.copyWith(status: LoginStatusLoading()),
    ),
    TypedReducer<LoginState, LoginSuccessAction>(
      (state, _) => state.copyWith(status: LoginStatusSuccess()),
    ),
    TypedReducer<LoginState, LoginFailedAction>(
      (state, action) => state.copyWith(status: LoginStatusFailed(action.code)),
    ),
  ]);
}
