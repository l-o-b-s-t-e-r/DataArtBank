import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/models/states/transactions_state.dart';

class TransactionsSelector {
  static TransactionsState select(AppState state) => state.transactionsState;
}
