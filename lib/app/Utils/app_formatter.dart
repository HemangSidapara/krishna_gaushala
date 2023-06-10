import 'package:intl/intl.dart';

extension StringToInt on String {
  int toInt() {
    return int.parse(this);
  }
}

extension StringToDouble on String {
  double toDouble() {
    return double.parse(this);
  }
}

extension RupeesFormatterFromInt on int {
  String toRupees({String? symbol}) {
    return indianRupeesFormat(symbol: symbol).format(this);
  }
}

extension RupeesFormatterFromDouble on double {
  String toRupees({String? symbol}) {
    return indianRupeesFormat(symbol: symbol).format(this);
  }
}

extension RupeesFormatterFromString on String {
  String toRupees({String? symbol}) {
    return indianRupeesFormat(symbol: symbol).format(int.parse(this));
  }
}

indianRupeesFormat({String? symbol}) => NumberFormat.currency(name: "INR", locale: 'en_IN', decimalDigits: 0, symbol: symbol ?? '');

extension RupeesGrandTotalFromList on List {
  String grandTotal() {
    double totalAmount = 0.0;
    for (var element in this) {
      totalAmount = totalAmount + element.amount!.toString().toDouble();
    }
    return totalAmount.toString();
  }
}
