import 'package:hive/hive.dart';
import 'package:find_job/features/profile/domain/entities/experience_entity.dart';

part 'experience_model.g.dart';

@HiveType(typeId: 2)
class ExperienceModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String company;

  @HiveField(2)
  String position;

  @HiveField(3)
  DateTime startDate;

  @HiveField(4)
  DateTime? endDate;

  @HiveField(5)
  String bio;

  ExperienceModel({
    required this.id,
    required this.company,
    required this.position,
    required this.startDate,
    this.endDate,
    required this.bio,
  });

  // Convert to domain entity
  ExperienceEntity toEntity() {
    return ExperienceEntity(
      id: id,
      company: company,
      position: position,
      startDate: startDate,
      endDate: endDate,
      bio: bio,
    );
  }

  // Create from domain entity
  factory ExperienceModel.fromEntity(ExperienceEntity entity) {
    return ExperienceModel(
      id: entity.id,
      company: entity.company,
      position: entity.position,
      startDate: entity.startDate,
      endDate: entity.endDate,
      bio: entity.bio,
    );
  }

  // For easy initialization
  factory ExperienceModel.empty() {
    return ExperienceModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      company: '',
      position: '',
      startDate: DateTime.now(),
      endDate: null,
      bio: '',
    );
  }
}
