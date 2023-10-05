import 'package:data_art_bank/models/transaction_type.dart';
import 'package:data_art_bank/ui/widgets/donut_chart.dart';
import 'package:flutter/material.dart';

class TransactionsDonutChart extends StatelessWidget {
  const TransactionsDonutChart({required this.values, super.key});

  final Map<Color, double> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: DonutChart(values: values),
        ),
        ChartLegend(values: TransactionType.colorNameMap)
      ],
    );
  }
}
