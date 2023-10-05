import 'dart:ui';

enum TransactionType {
  transfer,
  deposit,
  withdrawal;

  static final Map<Color, String> colorNameMap = Map.fromEntries(
    TransactionType.values.map((e) => MapEntry(e.chartColor, e.name)),
  );

  bool get isDeposit => this == deposit;

  String get sign => switch (this) {
        TransactionType.deposit => '+',
        _ => '-',
      };

  Color get chartColor => switch (this) {
        TransactionType.transfer => const Color(0xFF243965),
        TransactionType.deposit => const Color(0xFF6EBFDF),
        TransactionType.withdrawal => const Color(0xFFE59635),
      };
}
