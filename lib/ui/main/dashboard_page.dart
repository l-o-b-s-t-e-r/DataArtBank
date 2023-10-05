import 'package:collection/collection.dart';
import 'package:data_art_bank/models/dtos/transaction_overview.dart';
import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/models/transaction_type.dart';
import 'package:data_art_bank/selectors/transactions_selector.dart';
import 'package:data_art_bank/ui/main/transactions_donut_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Map<Color, double> convertTransactions(
    List<TransactionOverview> transactions,
  ) {
    final groupedByTypeSumOfTransactions =
        transactions.groupFoldBy<TransactionType, double>(
      (t) => t.type,
      (amount, t) => (amount ?? 0.0) + t.amount,
    );

    final sortedByTypeSumOfTransactions = groupedByTypeSumOfTransactions.entries
        .toList()
      ..sort((e1, e2) => e1.key.index.compareTo(e2.key.index));

    final colorPerSumOfTransactionsList = sortedByTypeSumOfTransactions
        .map((e) => MapEntry(e.key.chartColor, e.value));

    return Map.fromEntries(colorPerSumOfTransactionsList);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, viewModel) {
          return TransactionsDonutChart(values: viewModel.transactionsSummary);
        });
  }
}

class _ViewModel {
  final List<TransactionOverview> transactions;

  _ViewModel({required this.transactions});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      transactions: TransactionsSelector.select(store.state).transactions,
    );
  }

  late final Map<Color, double> transactionsSummary =
      _calculateTransactionsSummary();

  Map<Color, double> _calculateTransactionsSummary() {
    final groupedByTypeSumOfTransactions =
        transactions.groupFoldBy<TransactionType, double>(
      (t) => t.type,
      (amount, t) => (amount ?? 0.0) + t.amount,
    );

    final sortedByTypeSumOfTransactions = groupedByTypeSumOfTransactions.entries
        .toList()
      ..sort((e1, e2) => e1.key.index.compareTo(e2.key.index));

    final colorPerSumOfTransactionsList = sortedByTypeSumOfTransactions
        .map((e) => MapEntry(e.key.chartColor, e.value));

    return Map.fromEntries(colorPerSumOfTransactionsList);
  }
}
