class AchievementEntity {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  AchievementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  AchievementEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return AchievementEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
