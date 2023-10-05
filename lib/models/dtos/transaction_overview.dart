import 'package:data_art_bank/models/transaction_type.dart';

class TransactionOverview {
  TransactionOverview({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
  });

  final String id;
  final TransactionType type;
  final double amount;
  final String currency;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionOverview &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          amount == other.amount &&
          currency == other.currency;

  @override
  int get hashCode =>
      id.hashCode ^ type.hashCode ^ amount.hashCode ^ currency.hashCode;
}
