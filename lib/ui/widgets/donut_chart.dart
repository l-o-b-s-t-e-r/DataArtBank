import 'dart:math';

import 'package:data_art_bank/extensions.dart';
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({
    this.holeColor,
    required this.values,
    super.key,
  });

  final Color? holeColor;
  final Map<Color, double> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: _DonutChartPainter(
          values: values,
          holeColor: holeColor ?? context.colors.surface,
        ),
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  _DonutChartPainter({
    required this.holeColor,
    required this.values,
  });

  final Color holeColor;
  final Map<Color, double> values;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;
    final Paint paint = Paint()..style = PaintingStyle.fill;

    final totalValue = values.values.fold(0.0, (a, b) => a + b);

    double startAngle = -pi / 2;

    values.forEach((color, value) {
      final double proportion = value / totalValue;
      final sweepAngle = proportion * 2 * pi;

      paint.color = color;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    });

    paint.color = holeColor;
    canvas.drawCircle(Offset(centerX, centerY), radius / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ChartLegend extends StatelessWidget {
  const ChartLegend({required this.values, super.key});

  final Map<Color, String> values;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: values.entries
          .map((e) => _ChartLabel(color: e.key, label: e.value))
          .toList(),
    );
  }
}

class _ChartLabel extends StatelessWidget {
  const _ChartLabel({
    required this.color,
    required this.label,
    super.key,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: 8,
            child: ColoredBox(color: color),
          ),
          const SizedBox(width: 2),
          Text(label),
        ],
      ),
    );
  }
}
