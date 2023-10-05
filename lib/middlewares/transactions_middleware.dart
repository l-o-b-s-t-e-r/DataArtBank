import 'package:data_art_bank/actions/transaction_actions.dart';
import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/repositories/transactions_repository.dart';
import 'package:redux/redux.dart';

class TransactionsMiddleware {
  TransactionsMiddleware({required this.repository});

  final TransactionsRepository repository;

  List<Middleware<AppState>> create() {
    return [
      TypedMiddleware<AppState, LoadTransactionsAction>(_loadTransactions),
      TypedMiddleware<AppState, LoadTransactionDetailsAction>(
        _loadTransactionDetails,
      ),
    ];
  }

  void _loadTransactions(
    Store<AppState> store,
    LoadTransactionsAction action,
    NextDispatcher next,
  ) async {
    final transactions = await repository.loadTransactions();
    store.dispatch(LoadTransactionsSuccessAction(transactions: transactions));
  }

  void _loadTransactionDetails(
    Store<AppState> store,
    LoadTransactionDetailsAction action,
    NextDispatcher next,
  ) async {
    final transactionDetails =
        await repository.loadTransactionDetails(action.id);

    store.dispatch(LoadTransactionsDetailsSuccessAction(
      transactionDetails: transactionDetails,
    ));
  }
}
