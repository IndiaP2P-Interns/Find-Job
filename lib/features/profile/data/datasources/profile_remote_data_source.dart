import 'package:find_job/features/profile/data/models/profile_model.dart';
import 'package:find_job/features/profile/data/models/education_model.dart';
import 'package:find_job/features/profile/data/models/experience_model.dart';
import 'package:find_job/features/profile/data/models/project_model.dart';
import 'package:find_job/features/profile/data/models/achievement_model.dart';

/// Placeholder for future API integration
/// This class defines the structure for remote data operations
/// When implementing API calls:
/// 1. Inject DioClient
/// 2. Make API calls to backend endpoints
/// 3. Return the data models
/// 4. Handle API exceptions
class ProfileRemoteDataSource {
  // Future implementation:
  // final DioClient dioClient;
  // ProfileRemoteDataSource(this.dioClient);

  Future<ProfileModel> getProfile() async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> saveProfile(ProfileModel profile) async {
    throw UnimplementedError('API integration pending');
  }

  Future<List<EducationModel>> getEducations() async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> addEducation(EducationModel education) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> updateEducation(EducationModel education) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> deleteEducation(String id) async {
    throw UnimplementedError('API integration pending');
  }

  Future<List<ExperienceModel>> getExperiences() async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> addExperience(ExperienceModel experience) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> updateExperience(ExperienceModel experience) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> deleteExperience(String id) async {
    throw UnimplementedError('API integration pending');
  }

  Future<List<ProjectModel>> getProjects() async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> addProject(ProjectModel project) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> updateProject(ProjectModel project) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> deleteProject(String id) async {
    throw UnimplementedError('API integration pending');
  }

  Future<List<AchievementModel>> getAchievements() async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> addAchievement(AchievementModel achievement) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> updateAchievement(AchievementModel achievement) async {
    throw UnimplementedError('API integration pending');
  }

  Future<void> deleteAchievement(String id) async {
    throw UnimplementedError('API integration pending');
  }
}
