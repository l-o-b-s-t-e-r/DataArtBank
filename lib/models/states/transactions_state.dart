import 'package:data_art_bank/models/dtos/transaction_overview.dart';

class TransactionsState {
  const TransactionsState({required this.transactions});

  const TransactionsState.init() : this(transactions: const []);

  final List<TransactionOverview> transactions;

  TransactionsState copyWith({
    List<TransactionOverview>? transactions,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsState &&
          runtimeType == other.runtimeType &&
          transactions == other.transactions;

  @override
  int get hashCode => transactions.hashCode;
}
