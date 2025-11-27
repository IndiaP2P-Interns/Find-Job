class ExperienceEntity {
  final String id;
  final String company;
  final String position;
  final DateTime startDate;
  final DateTime? endDate;
  final String bio;

  ExperienceEntity({
    required this.id,
    required this.company,
    required this.position,
    required this.startDate,
    this.endDate,
    required this.bio,
  });

  ExperienceEntity copyWith({
    String? id,
    String? company,
    String? position,
    DateTime? startDate,
    DateTime? endDate,
    String? bio,
  }) {
    return ExperienceEntity(
      id: id ?? this.id,
      company: company ?? this.company,
      position: position ?? this.position,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      bio: bio ?? this.bio,
    );
  }
}
