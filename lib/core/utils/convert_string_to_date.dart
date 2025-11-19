DateTime? datePostedToDate(String? code) {
  if (code == null) return null;

  final now = DateTime.now();

  switch (code) {
    case "24h":
      return now.subtract(const Duration(hours: 24));

    case "week":
      return now.subtract(const Duration(days: 7));

    case "month":
      return DateTime(now.year, now.month - 1, now.day);

    default:
      return null;
  }
}
