import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ASSETS on String {
  String toPNG() {
    return 'assets/images/png/$this.png';
  }

  String toSVG() {
    return 'assets/images/svg/$this.svg';
  }

  String toNUM() {
    return formatNumber(this);
  }
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

String formatNumber(String s) {
  if (s.isNotEmpty) {
    return NumberFormat.decimalPattern("en").format(double.parse(s));
  }
  return "";
}
