import 'package:hive/hive.dart';
import 'package:find_job/features/profile/domain/entities/project_entity.dart';

part 'project_model.g.dart';

@HiveType(typeId: 3)
class ProjectModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime startDate;

  @HiveField(4)
  DateTime? endDate;

  @HiveField(5)
  List<String> links;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.links,
  });

  // Convert to domain entity
  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      links: links,
    );
  }

  // Create from domain entity
  factory ProjectModel.fromEntity(ProjectEntity entity) {
    return ProjectModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      startDate: entity.startDate,
      endDate: entity.endDate,
      links: entity.links,
    );
  }

  // For easy initialization
  factory ProjectModel.empty() {
    return ProjectModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '',
      description: '',
      startDate: DateTime.now(),
      endDate: null,
      links: [],
    );
  }
}
