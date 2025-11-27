import 'package:hive/hive.dart';
import 'package:find_job/features/profile/domain/entities/achievement_entity.dart';

part 'achievement_model.g.dart';

@HiveType(typeId: 4)
class AchievementModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime date;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  // Convert to domain entity
  AchievementEntity toEntity() {
    return AchievementEntity(
      id: id,
      title: title,
      description: description,
      date: date,
    );
  }

  // Create from domain entity
  factory AchievementModel.fromEntity(AchievementEntity entity) {
    return AchievementModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      date: entity.date,
    );
  }

  // For easy initialization
  factory AchievementModel.empty() {
    return AchievementModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '',
      description: '',
      date: DateTime.now(),
    );
  }
}
