import 'package:hive/hive.dart';
import 'package:find_job/features/profile/domain/entities/education_entity.dart';

part 'education_model.g.dart';

@HiveType(typeId: 1)
class EducationModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String institution;

  @HiveField(2)
  String degree;

  @HiveField(3)
  String fieldOfStudy;

  @HiveField(4)
  DateTime startDate;

  @HiveField(5)
  DateTime? endDate;

  @HiveField(6)
  String bio;

  EducationModel({
    required this.id,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    this.endDate,
    required this.bio,
  });

  // Convert to domain entity
  EducationEntity toEntity() {
    return EducationEntity(
      id: id,
      institution: institution,
      degree: degree,
      fieldOfStudy: fieldOfStudy,
      startDate: startDate,
      endDate: endDate,
      bio: bio,
    );
  }

  // Create from domain entity
  factory EducationModel.fromEntity(EducationEntity entity) {
    return EducationModel(
      id: entity.id,
      institution: entity.institution,
      degree: entity.degree,
      fieldOfStudy: entity.fieldOfStudy,
      startDate: entity.startDate,
      endDate: entity.endDate,
      bio: entity.bio,
    );
  }

  // For easy initialization
  factory EducationModel.empty() {
    return EducationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      institution: '',
      degree: '',
      fieldOfStudy: '',
      startDate: DateTime.now(),
      endDate: null,
      bio: '',
    );
  }
}
