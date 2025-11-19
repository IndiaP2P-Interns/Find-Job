String formatSalaryRange(
  int minSalary,
  int maxSalary, {
  String currency = '₹',
}) {
  if (minSalary == 0 && maxSalary == 0) return "Not Disclosed";

  String formatNumber(int value) {
    return "${(value / 100000).toStringAsFixed(value % 100000 == 0 ? 0 : 1)}";
  }

  final min = formatNumber(minSalary);
  final max = formatNumber(maxSalary);

  return "$currency$min - $max LPA";
}
