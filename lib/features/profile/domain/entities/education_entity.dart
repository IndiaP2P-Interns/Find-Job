class EducationEntity {
  final String id;
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final DateTime startDate;
  final DateTime? endDate;
  final String bio;

  EducationEntity({
    required this.id,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    this.endDate,
    required this.bio,
  });

  EducationEntity copyWith({
    String? id,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    String? bio,
  }) {
    return EducationEntity(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      bio: bio ?? this.bio,
    );
  }
}
