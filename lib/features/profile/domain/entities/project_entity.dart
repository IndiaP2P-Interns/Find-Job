class ProjectEntity {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> links;

  ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.links,
  });

  ProjectEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? links,
  }) {
    return ProjectEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      links: links ?? this.links,
    );
  }
}
