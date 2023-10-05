import 'package:data_art_bank/models/dtos/transaction_details.dart';
import 'package:data_art_bank/models/dtos/transaction_overview.dart';
import 'package:data_art_bank/models/transaction_type.dart';

class TransactionsRepository {
  Future<List<TransactionOverview>> loadTransactions() async {
    return transactions;
  }

  Future<TransactionDetails> loadTransactionDetails(String id) async {
    final transactionOverview =
        transactions.firstWhere((element) => element.id == id);

    return TransactionDetails(
      id: transactionOverview.id,
      type: transactionOverview.type,
      amount: transactionOverview.amount,
      currency: transactionOverview.currency,
      fees: transactionOverview.amount * 0.01,
      date: DateTime.now(),
    );
  }

  final List<TransactionOverview> transactions = [
    TransactionOverview(
      id: '20',
      type: TransactionType.withdrawal,
      amount: 50,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '19',
      type: TransactionType.transfer,
      amount: 0.99,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '18',
      type: TransactionType.transfer,
      amount: 1.99,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '17',
      type: TransactionType.transfer,
      amount: 45.55,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '16',
      type: TransactionType.deposit,
      amount: 50,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '15',
      type: TransactionType.withdrawal,
      amount: 100,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '14',
      type: TransactionType.transfer,
      amount: 19.94,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '13',
      type: TransactionType.transfer,
      amount: 44.66,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '12',
      type: TransactionType.transfer,
      amount: 21.21,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '11',
      type: TransactionType.deposit,
      amount: 10,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '10',
      type: TransactionType.withdrawal,
      amount: 50,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '9',
      type: TransactionType.transfer,
      amount: 34.43,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '8',
      type: TransactionType.transfer,
      amount: 11.59,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '7',
      type: TransactionType.transfer,
      amount: 99.99,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '6',
      type: TransactionType.deposit,
      amount: 50,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '5',
      type: TransactionType.withdrawal,
      amount: 50,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '4',
      type: TransactionType.transfer,
      amount: 2.99,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '3',
      type: TransactionType.transfer,
      amount: 6.0,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '2',
      type: TransactionType.transfer,
      amount: 19.99,
      currency: 'USD',
    ),
    TransactionOverview(
      id: '1',
      type: TransactionType.deposit,
      amount: 100,
      currency: 'USD',
    ),
  ];
}
