import 'package:data_art_bank/models/transaction_type.dart';

class TransactionDetails {
  TransactionDetails({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    required this.fees,
    required this.date,
  });

  final String id;
  final TransactionType type;
  final double amount;
  final String currency;
  final double fees;
  final DateTime date;

  late final total = amount + fees;
  late final amountWithCurrency = '${amount} ${currency}';
  late final feesWithCurrency = '${fees.toStringAsFixed(2)} ${currency}';
  late final totalWithCurrency = '${total.toStringAsFixed(2)} ${currency}';
}
