import 'package:data_art_bank/models/states/login_state.dart';
import 'package:data_art_bank/models/states/transaction_details_state.dart';
import 'package:data_art_bank/models/states/transactions_state.dart';

class AppState {
  final LoginState loginState;
  final TransactionsState transactionsState;
  final TransactionDetailsState transactionDetailsState;

  AppState({
    required this.loginState,
    required this.transactionsState,
    required this.transactionDetailsState,
  });

  factory AppState.init() => AppState(
        loginState: const LoginState.init(),
        transactionsState: const TransactionsState.init(),
        transactionDetailsState: const TransactionDetailsState.init(),
      );

  AppState copyWith({
    LoginState? loginState,
    TransactionsState? transactionsState,
    TransactionDetailsState? transactionDetailsState,
  }) {
    return AppState(
      loginState: loginState ?? this.loginState,
      transactionsState: transactionsState ?? this.transactionsState,
      transactionDetailsState:
          transactionDetailsState ?? this.transactionDetailsState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          loginState == other.loginState &&
          transactionsState == other.transactionsState &&
          transactionDetailsState == other.transactionDetailsState;

  @override
  int get hashCode =>
      loginState.hashCode ^
      transactionsState.hashCode ^
      transactionDetailsState.hashCode;
}
