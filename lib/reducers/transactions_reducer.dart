import 'package:data_art_bank/actions/transaction_actions.dart';
import 'package:data_art_bank/models/states/transactions_state.dart';
import 'package:redux/redux.dart';

class TransactionsReducer {
  static final reduce = combineReducers<TransactionsState>([
    TypedReducer<TransactionsState, LoadTransactionsSuccessAction>(
      (state, action) => state.copyWith(transactions: action.transactions),
    ),
    TypedReducer<TransactionsState, DeleteTransactionAction>((state, action) {
      final transactionsCopy = state.transactions.toList();
      transactionsCopy.removeWhere((element) => element.id == action.id);

      return state.copyWith(transactions: transactionsCopy);
    }),
  ]);
}
