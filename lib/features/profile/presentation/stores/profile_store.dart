import 'package:mobx/mobx.dart';
import 'package:find_job/core/response_state.dart';
import 'package:find_job/features/profile/domain/usecases/profile_usecases.dart';
import 'package:find_job/features/profile/domain/entities/profile_entity.dart';
import 'package:find_job/features/profile/domain/entities/education_entity.dart';
import 'package:find_job/features/profile/domain/entities/experience_entity.dart';
import 'package:find_job/features/profile/domain/entities/project_entity.dart';
import 'package:find_job/features/profile/domain/entities/achievement_entity.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final ProfileUseCases useCases;

  _ProfileStore(this.useCases);

  // Edit mode
  @observable
  bool isEditMode = false;

  // Profile data
  @observable
  ProfileEntity? profile;

  @observable
  ObservableList<EducationEntity> educations = ObservableList<EducationEntity>();

  @observable
  ObservableList<ExperienceEntity> experiences = ObservableList<ExperienceEntity>();

  @observable
  ObservableList<ProjectEntity> projects = ObservableList<ProjectEntity>();

  @observable
  ObservableList<AchievementEntity> achievements = ObservableList<AchievementEntity>();

  // Loading states
  @observable
  bool isLoadingProfile = false;

  @observable
  bool isLoadingEducations = false;

  @observable
  bool isLoadingExperiences = false;

  @observable
  bool isLoadingProjects = false;

  @observable
  bool isLoadingAchievements = false;

  @observable
  bool isSaving = false;

  // Error states
  @observable
  String? errorMessage;

  // Initialize and load all data
  @action
  Future<void> initialize() async {
    await Future.wait([
      loadProfile(),
      loadEducations(),
      loadExperiences(),
      loadProjects(),
      loadAchievements(),
    ]);
  }

  // Profile operations
  @action
  Future<void> loadProfile() async {
    isLoadingProfile = true;
    errorMessage = null;

    final result = await useCases.getProfile();

    if (result is Success<ProfileEntity>) {
      profile = result.data;
    } else if (result is Error<ProfileEntity>) {
      errorMessage = result.message;
    }

    isLoadingProfile = false;
  }

  @action
  Future<bool> saveProfile(ProfileEntity updatedProfile) async {
    isSaving = true;
    errorMessage = null;

    final result = await useCases.saveProfile(updatedProfile);

    if (result is Success) {
      profile = updatedProfile;
      isSaving = false;
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      isSaving = false;
      return false;
    }

    isSaving = false;
    return false;
  }

  // Education operations
  @action
  Future<void> loadEducations() async {
    isLoadingEducations = true;
    errorMessage = null;

    final result = await useCases.getEducations();

    if (result is Success<List<EducationEntity>>) {
      educations = ObservableList.of(result.data);
    } else if (result is Error<List<EducationEntity>>) {
      errorMessage = result.message;
    }

    isLoadingEducations = false;
  }

  @action
  Future<bool> addEducation(EducationEntity education) async {
    errorMessage = null;

    final result = await useCases.addEducation(education);

    if (result is Success) {
      await loadEducations(); // Reload to get sorted list
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> updateEducation(EducationEntity education) async {
    errorMessage = null;

    final result = await useCases.updateEducation(education);

    if (result is Success) {
      await loadEducations(); // Reload to get sorted list
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> deleteEducation(String id) async {
    errorMessage = null;

    final result = await useCases.deleteEducation(id);

    if (result is Success) {
      educations.removeWhere((e) => e.id == id);
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  // Experience operations
  @action
  Future<void> loadExperiences() async {
    isLoadingExperiences = true;
    errorMessage = null;

    final result = await useCases.getExperiences();

    if (result is Success<List<ExperienceEntity>>) {
      experiences = ObservableList.of(result.data);
    } else if (result is Error<List<ExperienceEntity>>) {
      errorMessage = result.message;
    }

    isLoadingExperiences = false;
  }

  @action
  Future<bool> addExperience(ExperienceEntity experience) async {
    errorMessage = null;

    final result = await useCases.addExperience(experience);

    if (result is Success) {
      await loadExperiences();
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> updateExperience(ExperienceEntity experience) async {
    errorMessage = null;

    final result = await useCases.updateExperience(experience);

    if (result is Success) {
      await loadExperiences();
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> deleteExperience(String id) async {
    errorMessage = null;

    final result = await useCases.deleteExperience(id);

    if (result is Success) {
      experiences.removeWhere((e) => e.id == id);
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  // Project operations
  @action
  Future<void> loadProjects() async {
    isLoadingProjects = true;
    errorMessage = null;

    final result = await useCases.getProjects();

    if (result is Success<List<ProjectEntity>>) {
      projects = ObservableList.of(result.data);
    } else if (result is Error<List<ProjectEntity>>) {
      errorMessage = result.message;
    }

    isLoadingProjects = false;
  }

  @action
  Future<bool> addProject(ProjectEntity project) async {
    errorMessage = null;

    final result = await useCases.addProject(project);

    if (result is Success) {
      await loadProjects();
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> updateProject(ProjectEntity project) async {
    errorMessage = null;

    final result = await useCases.updateProject(project);

    if (result is Success) {
      await loadProjects();
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> deleteProject(String id) async {
    errorMessage = null;

    final result = await useCases.deleteProject(id);

    if (result is Success) {
      projects.removeWhere((p) => p.id == id);
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  // Achievement operations
  @action
  Future<void> loadAchievements() async {
    isLoadingAchievements = true;
    errorMessage = null;

    final result = await useCases.getAchievements();

    if (result is Success<List<AchievementEntity>>) {
      achievements = ObservableList.of(result.data);
    } else if (result is Error<List<AchievementEntity>>) {
      errorMessage = result.message;
    }

    isLoadingAchievements = false;
  }

  @action
  Future<bool> addAchievement(AchievementEntity achievement) async {
    errorMessage = null;

    final result = await useCases.addAchievement(achievement);

    if (result is Success) {
      await loadAchievements();
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> updateAchievement(AchievementEntity achievement) async {
    errorMessage = null;

    final result = await useCases.updateAchievement(achievement);

    if (result is Success) {
      await loadAchievements();
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  @action
  Future<bool> deleteAchievement(String id) async {
    errorMessage = null;

    final result = await useCases.deleteAchievement(id);

    if (result is Success) {
      achievements.removeWhere((a) => a.id == id);
      return true;
    } else if (result is Error) {
      errorMessage = result.message;
      return false;
    }

    return false;
  }

  // Toggle edit mode
  @action
  void toggleEditMode() {
    isEditMode = !isEditMode;
    errorMessage = null; // Clear error when toggling
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  // Add skill to profile
  @action
  Future<bool> addSkill(String skill) async {
    if (profile == null) return false;
    if (profile!.skills.contains(skill)) {
      errorMessage = 'Skill already exists';
      return false;
    }

    final updatedSkills = [...profile!.skills, skill];
    final updatedProfile = profile!.copyWith(skills: updatedSkills);
    return await saveProfile(updatedProfile);
  }

  // Remove skill from profile
  @action
  Future<bool> removeSkill(String skill) async {
    if (profile == null) return false;

    final updatedSkills = profile!.skills.where((s) => s != skill).toList();
    final updatedProfile = profile!.copyWith(skills: updatedSkills);
    return await saveProfile(updatedProfile);
  }

  @computed
  bool get isLoading =>
      isLoadingProfile ||
      isLoadingEducations ||
      isLoadingExperiences ||
      isLoadingProjects ||
      isLoadingAchievements;
}
