import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get styles => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;
}
