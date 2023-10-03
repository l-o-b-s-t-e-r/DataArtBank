import 'package:data_art_bank/models/app_state.dart';
import 'package:data_art_bank/models/login_state.dart';

class LoginSelector {
  static LoginState select(AppState state) => state.loginState;
}
