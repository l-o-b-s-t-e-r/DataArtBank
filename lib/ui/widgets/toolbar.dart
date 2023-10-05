import 'package:data_art_bank/extensions.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.styles.displayLarge!.copyWith(
        fontWeight: FontWeight.w900,
        color: context.colors.primary,
      ),
    );
  }
}
