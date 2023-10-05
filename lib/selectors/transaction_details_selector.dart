import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/models/states/transaction_details_state.dart';

class TransactionDetailsSelector {
  static TransactionDetailsState select(AppState state) =>
      state.transactionDetailsState;
}
