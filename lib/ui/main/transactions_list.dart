import 'package:data_art_bank/extensions.dart';
import 'package:data_art_bank/models/dtos/transaction_overview.dart';
import 'package:data_art_bank/ui/details/transaction_details_screen.dart';
import 'package:data_art_bank/ui/widgets/transaction_label.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({required this.transactions, super.key});

  final List<TransactionOverview> transactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.separated(
        itemCount: transactions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return _TransactionItem(model: transactions[index]);
        },
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({required this.model, super.key});

  final TransactionOverview model;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.secondaryContainer,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TransactionDetailsScreen.routeName,
            arguments: model.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('№${model.id}'),
                    const SizedBox(height: 4),
                    TransactionTypeLabel(type: model.type),
                  ],
                ),
              ),
              Text(
                '${model.type.sign}${model.amount} ${model.currency}',
                style: context.styles.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
