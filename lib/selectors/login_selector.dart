import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/models/states/login_state.dart';

class LoginSelector {
  static LoginState select(AppState state) => state.loginState;
}
