import 'package:data_art_bank/models/dtos/transaction_details.dart';
import 'package:data_art_bank/models/dtos/transaction_overview.dart';

class LoadTransactionsAction {}

class LoadTransactionsSuccessAction {
  LoadTransactionsSuccessAction({required this.transactions});

  final List<TransactionOverview> transactions;
}

class LoadTransactionDetailsAction {
  LoadTransactionDetailsAction({required this.id});

  final String id;
}

class LoadTransactionsDetailsSuccessAction {
  LoadTransactionsDetailsSuccessAction({required this.transactionDetails});

  final TransactionDetails transactionDetails;
}

class DeleteTransactionAction {
  DeleteTransactionAction({required this.id});

  final String id;
}
