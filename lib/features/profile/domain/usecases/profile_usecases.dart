import 'package:find_job/core/response_state.dart';
import 'package:find_job/features/profile/domain/repositories/profile_repository.dart';
import 'package:find_job/features/profile/domain/entities/profile_entity.dart';
import 'package:find_job/features/profile/domain/entities/education_entity.dart';
import 'package:find_job/features/profile/domain/entities/experience_entity.dart';
import 'package:find_job/features/profile/domain/entities/project_entity.dart';
import 'package:find_job/features/profile/domain/entities/achievement_entity.dart';

class ProfileUseCases {
  final ProfileRepository repository;

  ProfileUseCases(this.repository);

  // Profile operations
  Future<Response<ProfileEntity>> getProfile() {
    return repository.getProfile();
  }

  Future<Response<void>> saveProfile(ProfileEntity profile) {
    return repository.saveProfile(profile);
  }

  // Education operations
  Future<Response<List<EducationEntity>>> getEducations() {
    return repository.getEducations();
  }

  Future<Response<void>> addEducation(EducationEntity education) {
    // Validation: end date should be after start date if provided
    if (education.endDate != null && 
        education.endDate!.isBefore(education.startDate)) {
      return Future.value(Error('End date must be after start date'));
    }
    return repository.addEducation(education);
  }

  Future<Response<void>> updateEducation(EducationEntity education) {
    if (education.endDate != null && 
        education.endDate!.isBefore(education.startDate)) {
      return Future.value(Error('End date must be after start date'));
    }
    return repository.updateEducation(education);
  }

  Future<Response<void>> deleteEducation(String id) {
    return repository.deleteEducation(id);
  }

  // Experience operations
  Future<Response<List<ExperienceEntity>>> getExperiences() {
    return repository.getExperiences();
  }

  Future<Response<void>> addExperience(ExperienceEntity experience) {
    if (experience.endDate != null && 
        experience.endDate!.isBefore(experience.startDate)) {
      return Future.value(Error('End date must be after start date'));
    }
    return repository.addExperience(experience);
  }

  Future<Response<void>> updateExperience(ExperienceEntity experience) {
    if (experience.endDate != null && 
        experience.endDate!.isBefore(experience.startDate)) {
      return Future.value(Error('End date must be after start date'));
    }
    return repository.updateExperience(experience);
  }

  Future<Response<void>> deleteExperience(String id) {
    return repository.deleteExperience(id);
  }

  // Project operations
  Future<Response<List<ProjectEntity>>> getProjects() {
    return repository.getProjects();
  }

  Future<Response<void>> addProject(ProjectEntity project) {
    if (project.endDate != null && 
        project.endDate!.isBefore(project.startDate)) {
      return Future.value(Error('End date must be after start date'));
    }
    return repository.addProject(project);
  }

  Future<Response<void>> updateProject(ProjectEntity project) {
    if (project.endDate != null && 
        project.endDate!.isBefore(project.startDate)) {
      return Future.value(Error('End date must be after start date'));
    }
    return repository.updateProject(project);
  }

  Future<Response<void>> deleteProject(String id) {
    return repository.deleteProject(id);
  }

  // Achievement operations
  Future<Response<List<AchievementEntity>>> getAchievements() {
    return repository.getAchievements();
  }

  Future<Response<void>> addAchievement(AchievementEntity achievement) {
    return repository.addAchievement(achievement);
  }

  Future<Response<void>> updateAchievement(AchievementEntity achievement) {
    return repository.updateAchievement(achievement);
  }

  Future<Response<void>> deleteAchievement(String id) {
    return repository.deleteAchievement(id);
  }
}
