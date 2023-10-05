import 'package:data_art_bank/extensions.dart';
import 'package:data_art_bank/models/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionTypeLabel extends StatelessWidget {
  const TransactionTypeLabel({required this.type, super.key});

  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color:
            type.isDeposit ? Colors.green[600] : context.colors.errorContainer,
      ),
      child: Text(
        type.name,
        style: context.styles.labelLarge!.copyWith(
          color: type.isDeposit
              ? Colors.green[50]
              : context.colors.onErrorContainer,
        ),
      ),
    );
  }
}
