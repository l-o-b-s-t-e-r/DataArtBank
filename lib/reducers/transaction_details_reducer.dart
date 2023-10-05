import 'package:data_art_bank/actions/transaction_actions.dart';
import 'package:data_art_bank/models/states/transaction_details_state.dart';
import 'package:redux/redux.dart';

class TransactionDetailsReducer {
  static final reduce = combineReducers<TransactionDetailsState>([
    TypedReducer<TransactionDetailsState, LoadTransactionsDetailsSuccessAction>(
      (state, action) => state.copyWith(transaction: action.transactionDetails),
    ),
    TypedReducer<TransactionDetailsState, DeleteTransactionAction>(
      (state, action) => const TransactionDetailsState.init(),
    )
  ]);
}
