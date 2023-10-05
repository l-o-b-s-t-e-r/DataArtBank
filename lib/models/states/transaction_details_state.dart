import 'package:data_art_bank/models/dtos/transaction_details.dart';

class TransactionDetailsState {
  const TransactionDetailsState({this.transaction});

  const TransactionDetailsState.init() : this();

  final TransactionDetails? transaction;

  TransactionDetailsState copyWith({TransactionDetails? transaction}) {
    return TransactionDetailsState(
      transaction: transaction ?? this.transaction,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionDetailsState &&
          runtimeType == other.runtimeType &&
          transaction == other.transaction;

  @override
  int get hashCode => transaction.hashCode;
}
