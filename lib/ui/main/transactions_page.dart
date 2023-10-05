import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/models/states/transactions_state.dart';
import 'package:data_art_bank/selectors/transactions_selector.dart';
import 'package:data_art_bank/ui/main/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionsState>(
        distinct: true,
        converter: (Store<AppState> store) =>
            TransactionsSelector.select(store.state),
        builder: (context, transactionsState) {
          return TransactionsList(transactions: transactionsState.transactions);
        });
  }
}
