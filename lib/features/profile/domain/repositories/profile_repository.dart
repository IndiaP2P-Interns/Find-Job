import 'package:find_job/core/response_state.dart';
import 'package:find_job/features/profile/domain/entities/profile_entity.dart';
import 'package:find_job/features/profile/domain/entities/education_entity.dart';
import 'package:find_job/features/profile/domain/entities/experience_entity.dart';
import 'package:find_job/features/profile/domain/entities/project_entity.dart';
import 'package:find_job/features/profile/domain/entities/achievement_entity.dart';

abstract class ProfileRepository {
  // Profile operations
  Future<Response<ProfileEntity>> getProfile();
  Future<Response<void>> saveProfile(ProfileEntity profile);

  // Education operations
  Future<Response<List<EducationEntity>>> getEducations();
  Future<Response<void>> addEducation(EducationEntity education);
  Future<Response<void>> updateEducation(EducationEntity education);
  Future<Response<void>> deleteEducation(String id);

  // Experience operations
  Future<Response<List<ExperienceEntity>>> getExperiences();
  Future<Response<void>> addExperience(ExperienceEntity experience);
  Future<Response<void>> updateExperience(ExperienceEntity experience);
  Future<Response<void>> deleteExperience(String id);

  // Project operations
  Future<Response<List<ProjectEntity>>> getProjects();
  Future<Response<void>> addProject(ProjectEntity project);
  Future<Response<void>> updateProject(ProjectEntity project);
  Future<Response<void>> deleteProject(String id);

  // Achievement operations
  Future<Response<List<AchievementEntity>>> getAchievements();
  Future<Response<void>> addAchievement(AchievementEntity achievement);
  Future<Response<void>> updateAchievement(AchievementEntity achievement);
  Future<Response<void>> deleteAchievement(String id);
}
