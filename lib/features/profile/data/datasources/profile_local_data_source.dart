import 'package:hive/hive.dart';
import 'package:find_job/features/profile/data/models/profile_model.dart';
import 'package:find_job/features/profile/data/models/education_model.dart';
import 'package:find_job/features/profile/data/models/experience_model.dart';
import 'package:find_job/features/profile/data/models/project_model.dart';
import 'package:find_job/features/profile/data/models/achievement_model.dart';

class ProfileLocalDataSource {
  static const String _profileBox = 'profile';
  static const String _educationBox = 'education';
  static const String _experienceBox = 'experience';
  static const String _projectBox = 'project';
  static const String _achievementBox = 'achievement';

  // Profile operations
  Future<ProfileModel?> getProfile() async {
    try {
      final box = await Hive.openBox<ProfileModel>(_profileBox);
      if (box.isEmpty) {
        // Create and save default profile
        final defaultProfile = ProfileModel.empty();
        await box.put('profile', defaultProfile);
        return defaultProfile;
      }
      return box.get('profile');
    } catch (e) {
      throw Exception('Failed to get profile: ${e.toString()}');
    }
  }

  Future<void> saveProfile(ProfileModel profile) async {
    try {
      final box = await Hive.openBox<ProfileModel>(_profileBox);
      await box.put('profile', profile);
    } catch (e) {
      throw Exception('Failed to save profile: ${e.toString()}');
    }
  }

  // Education operations
  Future<List<EducationModel>> getEducations() async {
    try {
      final box = await Hive.openBox<EducationModel>(_educationBox);
      final educations = box.values.toList();
      // Sort by start date in descending order
      educations.sort((a, b) => b.startDate.compareTo(a.startDate));
      return educations;
    } catch (e) {
      throw Exception('Failed to get educations: ${e.toString()}');
    }
  }

  Future<void> addEducation(EducationModel education) async {
    try {
      final box = await Hive.openBox<EducationModel>(_educationBox);
      await box.put(education.id, education);
    } catch (e) {
      throw Exception('Failed to add education: ${e.toString()}');
    }
  }

  Future<void> updateEducation(EducationModel education) async {
    try {
      final box = await Hive.openBox<EducationModel>(_educationBox);
      await box.put(education.id, education);
    } catch (e) {
      throw Exception('Failed to update education: ${e.toString()}');
    }
  }

  Future<void> deleteEducation(String id) async {
    try {
      final box = await Hive.openBox<EducationModel>(_educationBox);
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete education: ${e.toString()}');
    }
  }

  // Experience operations
  Future<List<ExperienceModel>> getExperiences() async {
    try {
      final box = await Hive.openBox<ExperienceModel>(_experienceBox);
      final experiences = box.values.toList();
      // Sort by start date in descending order
      experiences.sort((a, b) => b.startDate.compareTo(a.startDate));
      return experiences;
    } catch (e) {
      throw Exception('Failed to get experiences: ${e.toString()}');
    }
  }

  Future<void> addExperience(ExperienceModel experience) async {
    try {
      final box = await Hive.openBox<ExperienceModel>(_experienceBox);
      await box.put(experience.id, experience);
    } catch (e) {
      throw Exception('Failed to add experience: ${e.toString()}');
    }
  }

  Future<void> updateExperience(ExperienceModel experience) async {
    try {
      final box = await Hive.openBox<ExperienceModel>(_experienceBox);
      await box.put(experience.id, experience);
    } catch (e) {
      throw Exception('Failed to update experience: ${e.toString()}');
    }
  }

  Future<void> deleteExperience(String id) async {
    try {
      final box = await Hive.openBox<ExperienceModel>(_experienceBox);
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete experience: ${e.toString()}');
    }
  }

  // Project operations
  Future<List<ProjectModel>> getProjects() async {
    try {
      final box = await Hive.openBox<ProjectModel>(_projectBox);
      final projects = box.values.toList();
      // Sort by start date in descending order
      projects.sort((a, b) => b.startDate.compareTo(a.startDate));
      return projects;
    } catch (e) {
      throw Exception('Failed to get projects: ${e.toString()}');
    }
  }

  Future<void> addProject(ProjectModel project) async {
    try {
      final box = await Hive.openBox<ProjectModel>(_projectBox);
      await box.put(project.id, project);
    } catch (e) {
      throw Exception('Failed to add project: ${e.toString()}');
    }
  }

  Future<void> updateProject(ProjectModel project) async {
    try {
      final box = await Hive.openBox<ProjectModel>(_projectBox);
      await box.put(project.id, project);
    } catch (e) {
      throw Exception('Failed to update project: ${e.toString()}');
    }
  }

  Future<void> deleteProject(String id) async {
    try {
      final box = await Hive.openBox<ProjectModel>(_projectBox);
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete project: ${e.toString()}');
    }
  }

  // Achievement operations
  Future<List<AchievementModel>> getAchievements() async {
    try {
      final box = await Hive.openBox<AchievementModel>(_achievementBox);
      final achievements = box.values.toList();
      // Sort by date in descending order
      achievements.sort((a, b) => b.date.compareTo(a.date));
      return achievements;
    } catch (e) {
      throw Exception('Failed to get achievements: ${e.toString()}');
    }
  }

  Future<void> addAchievement(AchievementModel achievement) async {
    try {
      final box = await Hive.openBox<AchievementModel>(_achievementBox);
      await box.put(achievement.id, achievement);
    } catch (e) {
      throw Exception('Failed to add achievement: ${e.toString()}');
    }
  }

  Future<void> updateAchievement(AchievementModel achievement) async {
    try {
      final box = await Hive.openBox<AchievementModel>(_achievementBox);
      await box.put(achievement.id, achievement);
    } catch (e) {
      throw Exception('Failed to update achievement: ${e.toString()}');
    }
  }

  Future<void> deleteAchievement(String id) async {
    try {
      final box = await Hive.openBox<AchievementModel>(_achievementBox);
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete achievement: ${e.toString()}');
    }
  }
}
