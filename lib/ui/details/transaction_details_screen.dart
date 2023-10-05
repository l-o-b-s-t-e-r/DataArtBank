import 'package:data_art_bank/actions/transaction_actions.dart';
import 'package:data_art_bank/extensions.dart';
import 'package:data_art_bank/models/dtos/transaction_details.dart';
import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/models/states/transaction_details_state.dart';
import 'package:data_art_bank/selectors/transaction_details_selector.dart';
import 'package:data_art_bank/ui/widgets/toolbar.dart';
import 'package:data_art_bank/ui/widgets/transaction_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({required this.id, super.key});

  static const routeName = '/transaction-details';

  final String id;

  void onInit(Store<AppState> store) {
    store.dispatch(LoadTransactionDetailsAction(id: id));
  }

  void onWillChange(
    TransactionDetailsState? prev,
    TransactionDetailsState current,
    BuildContext context,
  ) {
    if (prev?.transaction != null && current.transaction == null) {
      Navigator.of(context).pop();
    }
  }

  void onDeletePressed(BuildContext context) {
    StoreProvider.of<AppState>(context)
        .dispatch(DeleteTransactionAction(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Toolbar(text: '№$id'),
            ),
            Expanded(
              child: StoreConnector<AppState, TransactionDetailsState>(
                distinct: true,
                onInit: onInit,
                onWillChange: (prev, current) =>
                    onWillChange(prev, current, context),
                converter: (Store<AppState> store) =>
                    TransactionDetailsSelector.select(store.state),
                builder: (context, transactionState) {
                  final transaction = transactionState.transaction;
                  return transaction != null
                      ? _TransactionDetailsContent(
                          transaction: transaction,
                          onDeletePressed: onDeletePressed,
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionDetailsContent extends StatelessWidget {
  const _TransactionDetailsContent({
    required this.transaction,
    required this.onDeletePressed,
    super.key,
  });

  final TransactionDetails transaction;
  final void Function(BuildContext) onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TransactionOverview(transaction: transaction),
          const SizedBox(height: 16),
          _TransactionDetails(transaction: transaction),
          const Spacer(),
          _DeleteTransaction(onPressed: onDeletePressed),
        ],
      ),
    );
  }
}

class _TransactionOverview extends StatelessWidget {
  const _TransactionOverview({
    required this.transaction,
    super.key,
  });

  final TransactionDetails transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${transaction.type.sign}${transaction.amountWithCurrency}',
              style: context.styles.displaySmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              DateFormat.yMMMMd().format(transaction.date),
            ),
          ],
        ),
        const Spacer(),
        TransactionTypeLabel(type: transaction.type),
      ],
    );
  }
}

class _TransactionDetails extends StatelessWidget {
  const _TransactionDetails({
    required this.transaction,
    super.key,
  });

  final TransactionDetails transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colors.surfaceVariant,
      ),
      child: Column(
        children: [
          _TransactionDetailsRow(
            title: 'Amount',
            value: transaction.amountWithCurrency,
          ),
          const SizedBox(height: 8),
          _TransactionDetailsRow(
            title: 'Fees',
            value: transaction.feesWithCurrency,
          ),
          const SizedBox(height: 8),
          _TransactionDetailsRow(
            title: 'Total',
            value: transaction.totalWithCurrency,
          ),
        ],
      ),
    );
  }
}

class _TransactionDetailsRow extends StatelessWidget {
  const _TransactionDetailsRow({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        Text(value),
      ],
    );
  }
}

class _DeleteTransaction extends StatelessWidget {
  const _DeleteTransaction({required this.onPressed, super.key});

  final void Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colors.error,
        foregroundColor: context.colors.onError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('DELETE'),
      ),
    );
  }
}
