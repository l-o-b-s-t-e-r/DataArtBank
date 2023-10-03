import 'package:data_art_bank/actions/actions.dart';
import 'package:data_art_bank/models/app_state.dart';
import 'package:data_art_bank/models/login_state.dart';
import 'package:redux/redux.dart';

class AppReducer {
  static AppState create(AppState state, action) {
    return AppState(
      loginState: _loadingReducer(state.loginState, action),
    );
  }

  static final _loadingReducer = combineReducers<LoginState>([
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
