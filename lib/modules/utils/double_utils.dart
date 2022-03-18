String formatDoubleOr0(double? num) {
  return num?.toStringAsFixed(2) ?? "0";
}

double tryParseDoubleOr0(Object? source){
  return double.tryParse(source?.toString() ?? "0") ?? 0;
}
