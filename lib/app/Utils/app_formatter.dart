import 'package:intl/intl.dart';

extension RupeesFormatterFromInt on int {
  String toRupees() {
    return indianRupeesFormat.format(this);
  }
}

extension RupeesFormatterFromString on String {
  String toRupees() {
    return indianRupeesFormat.format(int.parse(this));
  }
}

final indianRupeesFormat = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 0,
  symbol: ''
);
