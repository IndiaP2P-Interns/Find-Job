import 'package:hive/hive.dart';
import 'package:find_job/features/profile/domain/entities/profile_entity.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 0)
class ProfileModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String address;

  @HiveField(4)
  String about;

  @HiveField(5)
  List<String> skills;

  @HiveField(6)
  String? resumePath;

  ProfileModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.about,
    required this.skills,
    this.resumePath,
  });

  // Convert to domain entity
  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      name: name,
      phone: phone,
      address: address,
      about: about,
      skills: skills,
      resumePath: resumePath,
    );
  }

  // Create from domain entity
  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      about: entity.about,
      skills: entity.skills,
      resumePath: entity.resumePath,
    );
  }

  // For easy initialization
  factory ProfileModel.empty() {
    return ProfileModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      phone: '',
      address: '',
      about: '',
      skills: [],
      resumePath: null,
    );
  }
}
