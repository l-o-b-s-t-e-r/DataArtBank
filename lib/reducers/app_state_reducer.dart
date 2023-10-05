import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/reducers/login_reducer.dart';
import 'package:data_art_bank/reducers/transaction_details_reducer.dart';
import 'package:data_art_bank/reducers/transactions_reducer.dart';

class AppReducer {
  static AppState create(AppState state, action) {
    return AppState(
      loginState: LoginReducer.reduce(state.loginState, action),
      transactionsState:
          TransactionsReducer.reduce(state.transactionsState, action),
      transactionDetailsState: TransactionDetailsReducer.reduce(
        state.transactionDetailsState,
        action,
      ),
    );
  }
}
