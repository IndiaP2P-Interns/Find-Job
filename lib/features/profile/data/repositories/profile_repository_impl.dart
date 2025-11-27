import 'package:find_job/core/response_state.dart';
import 'package:find_job/features/profile/domain/repositories/profile_repository.dart';
import 'package:find_job/features/profile/domain/entities/profile_entity.dart';
import 'package:find_job/features/profile/domain/entities/education_entity.dart';
import 'package:find_job/features/profile/domain/entities/experience_entity.dart';
import 'package:find_job/features/profile/domain/entities/project_entity.dart';
import 'package:find_job/features/profile/domain/entities/achievement_entity.dart';
import 'package:find_job/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:find_job/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:find_job/features/profile/data/models/profile_model.dart';
import 'package:find_job/features/profile/data/models/education_model.dart';
import 'package:find_job/features/profile/data/models/experience_model.dart';
import 'package:find_job/features/profile/data/models/project_model.dart';
import 'package:find_job/features/profile/data/models/achievement_model.dart';
import 'package:flutter/material.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.localDataSource, this.remoteDataSource);

  // Profile operations
  @override
  Future<Response<ProfileEntity>> getProfile() async {
    try {
      // Future: Check network and try remote first, then fallback to local
      final profile = await localDataSource.getProfile();
      if (profile == null) {
        return Error('Profile not found');
      }
      return Success(profile.toEntity());
    } catch (e) {
      debugPrint('[ProfileRepo] Get profile error: ${e.toString()}');
      return Error('Failed to load profile: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> saveProfile(ProfileEntity profile) async {
    try {
      final model = ProfileModel.fromEntity(profile);
      await localDataSource.saveProfile(model);
      // Future: Sync with remote
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Save profile error: ${e.toString()}');
      return Error('Failed to save profile: ${e.toString()}');
    }
  }

  // Education operations
  @override
  Future<Response<List<EducationEntity>>> getEducations() async {
    try {
      final educations = await localDataSource.getEducations();
      return Success(educations.map((e) => e.toEntity()).toList());
    } catch (e) {
      debugPrint('[ProfileRepo] Get educations error: ${e.toString()}');
      return Error('Failed to load educations: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> addEducation(EducationEntity education) async {
    try {
      final model = EducationModel.fromEntity(education);
      await localDataSource.addEducation(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Add education error: ${e.toString()}');
      return Error('Failed to add education: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> updateEducation(EducationEntity education) async {
    try {
      final model = EducationModel.fromEntity(education);
      await localDataSource.updateEducation(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Update education error: ${e.toString()}');
      return Error('Failed to update education: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> deleteEducation(String id) async {
    try {
      await localDataSource.deleteEducation(id);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Delete education error: ${e.toString()}');
      return Error('Failed to delete education: ${e.toString()}');
    }
  }

  // Experience operations
  @override
  Future<Response<List<ExperienceEntity>>> getExperiences() async {
    try {
      final experiences = await localDataSource.getExperiences();
      return Success(experiences.map((e) => e.toEntity()).toList());
    } catch (e) {
      debugPrint('[ProfileRepo] Get experiences error: ${e.toString()}');
      return Error('Failed to load experiences: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> addExperience(ExperienceEntity experience) async {
    try {
      final model = ExperienceModel.fromEntity(experience);
      await localDataSource.addExperience(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Add experience error: ${e.toString()}');
      return Error('Failed to add experience: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> updateExperience(ExperienceEntity experience) async {
    try {
      final model = ExperienceModel.fromEntity(experience);
      await localDataSource.updateExperience(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Update experience error: ${e.toString()}');
      return Error('Failed to update experience: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> deleteExperience(String id) async {
    try {
      await localDataSource.deleteExperience(id);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Delete experience error: ${e.toString()}');
      return Error('Failed to delete experience: ${e.toString()}');
    }
  }

  // Project operations
  @override
  Future<Response<List<ProjectEntity>>> getProjects() async {
    try {
      final projects = await localDataSource.getProjects();
      return Success(projects.map((e) => e.toEntity()).toList());
    } catch (e) {
      debugPrint('[ProfileRepo] Get projects error: ${e.toString()}');
      return Error('Failed to load projects: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> addProject(ProjectEntity project) async {
    try {
      final model = ProjectModel.fromEntity(project);
      await localDataSource.addProject(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Add project error: ${e.toString()}');
      return Error('Failed to add project: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> updateProject(ProjectEntity project) async {
    try {
      final model = ProjectModel.fromEntity(project);
      await localDataSource.updateProject(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Update project error: ${e.toString()}');
      return Error('Failed to update project: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> deleteProject(String id) async {
    try {
      await localDataSource.deleteProject(id);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Delete project error: ${e.toString()}');
      return Error('Failed to delete project: ${e.toString()}');
    }
  }

  // Achievement operations
  @override
  Future<Response<List<AchievementEntity>>> getAchievements() async {
    try {
      final achievements = await localDataSource.getAchievements();
      return Success(achievements.map((e) => e.toEntity()).toList());
    } catch (e) {
      debugPrint('[ProfileRepo] Get achievements error: ${e.toString()}');
      return Error('Failed to load achievements: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> addAchievement(AchievementEntity achievement) async {
    try {
      final model = AchievementModel.fromEntity(achievement);
      await localDataSource.addAchievement(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Add achievement error: ${e.toString()}');
      return Error('Failed to add achievement: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> updateAchievement(AchievementEntity achievement) async {
    try {
      final model = AchievementModel.fromEntity(achievement);
      await localDataSource.updateAchievement(model);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Update achievement error: ${e.toString()}');
      return Error('Failed to update achievement: ${e.toString()}');
    }
  }

  @override
  Future<Response<void>> deleteAchievement(String id) async {
    try {
      await localDataSource.deleteAchievement(id);
      return Success(null);
    } catch (e) {
      debugPrint('[ProfileRepo] Delete achievement error: ${e.toString()}');
      return Error('Failed to delete achievement: ${e.toString()}');
    }
  }
}
