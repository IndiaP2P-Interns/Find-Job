// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_ProfileStore.isLoading'))
          .value;

  late final _$isEditModeAtom =
      Atom(name: '_ProfileStore.isEditMode', context: context);

  @override
  bool get isEditMode {
    _$isEditModeAtom.reportRead();
    return super.isEditMode;
  }

  @override
  set isEditMode(bool value) {
    _$isEditModeAtom.reportWrite(value, super.isEditMode, () {
      super.isEditMode = value;
    });
  }

  late final _$profileAtom =
      Atom(name: '_ProfileStore.profile', context: context);

  @override
  ProfileEntity? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(ProfileEntity? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  late final _$educationsAtom =
      Atom(name: '_ProfileStore.educations', context: context);

  @override
  ObservableList<EducationEntity> get educations {
    _$educationsAtom.reportRead();
    return super.educations;
  }

  @override
  set educations(ObservableList<EducationEntity> value) {
    _$educationsAtom.reportWrite(value, super.educations, () {
      super.educations = value;
    });
  }

  late final _$experiencesAtom =
      Atom(name: '_ProfileStore.experiences', context: context);

  @override
  ObservableList<ExperienceEntity> get experiences {
    _$experiencesAtom.reportRead();
    return super.experiences;
  }

  @override
  set experiences(ObservableList<ExperienceEntity> value) {
    _$experiencesAtom.reportWrite(value, super.experiences, () {
      super.experiences = value;
    });
  }

  late final _$projectsAtom =
      Atom(name: '_ProfileStore.projects', context: context);

  @override
  ObservableList<ProjectEntity> get projects {
    _$projectsAtom.reportRead();
    return super.projects;
  }

  @override
  set projects(ObservableList<ProjectEntity> value) {
    _$projectsAtom.reportWrite(value, super.projects, () {
      super.projects = value;
    });
  }

  late final _$achievementsAtom =
      Atom(name: '_ProfileStore.achievements', context: context);

  @override
  ObservableList<AchievementEntity> get achievements {
    _$achievementsAtom.reportRead();
    return super.achievements;
  }

  @override
  set achievements(ObservableList<AchievementEntity> value) {
    _$achievementsAtom.reportWrite(value, super.achievements, () {
      super.achievements = value;
    });
  }

  late final _$isLoadingProfileAtom =
      Atom(name: '_ProfileStore.isLoadingProfile', context: context);

  @override
  bool get isLoadingProfile {
    _$isLoadingProfileAtom.reportRead();
    return super.isLoadingProfile;
  }

  @override
  set isLoadingProfile(bool value) {
    _$isLoadingProfileAtom.reportWrite(value, super.isLoadingProfile, () {
      super.isLoadingProfile = value;
    });
  }

  late final _$isLoadingEducationsAtom =
      Atom(name: '_ProfileStore.isLoadingEducations', context: context);

  @override
  bool get isLoadingEducations {
    _$isLoadingEducationsAtom.reportRead();
    return super.isLoadingEducations;
  }

  @override
  set isLoadingEducations(bool value) {
    _$isLoadingEducationsAtom.reportWrite(value, super.isLoadingEducations, () {
      super.isLoadingEducations = value;
    });
  }

  late final _$isLoadingExperiencesAtom =
      Atom(name: '_ProfileStore.isLoadingExperiences', context: context);

  @override
  bool get isLoadingExperiences {
    _$isLoadingExperiencesAtom.reportRead();
    return super.isLoadingExperiences;
  }

  @override
  set isLoadingExperiences(bool value) {
    _$isLoadingExperiencesAtom.reportWrite(value, super.isLoadingExperiences,
        () {
      super.isLoadingExperiences = value;
    });
  }

  late final _$isLoadingProjectsAtom =
      Atom(name: '_ProfileStore.isLoadingProjects', context: context);

  @override
  bool get isLoadingProjects {
    _$isLoadingProjectsAtom.reportRead();
    return super.isLoadingProjects;
  }

  @override
  set isLoadingProjects(bool value) {
    _$isLoadingProjectsAtom.reportWrite(value, super.isLoadingProjects, () {
      super.isLoadingProjects = value;
    });
  }

  late final _$isLoadingAchievementsAtom =
      Atom(name: '_ProfileStore.isLoadingAchievements', context: context);

  @override
  bool get isLoadingAchievements {
    _$isLoadingAchievementsAtom.reportRead();
    return super.isLoadingAchievements;
  }

  @override
  set isLoadingAchievements(bool value) {
    _$isLoadingAchievementsAtom.reportWrite(value, super.isLoadingAchievements,
        () {
      super.isLoadingAchievements = value;
    });
  }

  late final _$isSavingAtom =
      Atom(name: '_ProfileStore.isSaving', context: context);

  @override
  bool get isSaving {
    _$isSavingAtom.reportRead();
    return super.isSaving;
  }

  @override
  set isSaving(bool value) {
    _$isSavingAtom.reportWrite(value, super.isSaving, () {
      super.isSaving = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ProfileStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('_ProfileStore.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$loadProfileAsyncAction =
      AsyncAction('_ProfileStore.loadProfile', context: context);

  @override
  Future<void> loadProfile() {
    return _$loadProfileAsyncAction.run(() => super.loadProfile());
  }

  late final _$saveProfileAsyncAction =
      AsyncAction('_ProfileStore.saveProfile', context: context);

  @override
  Future<bool> saveProfile(ProfileEntity updatedProfile) {
    return _$saveProfileAsyncAction
        .run(() => super.saveProfile(updatedProfile));
  }

  late final _$loadEducationsAsyncAction =
      AsyncAction('_ProfileStore.loadEducations', context: context);

  @override
  Future<void> loadEducations() {
    return _$loadEducationsAsyncAction.run(() => super.loadEducations());
  }

  late final _$addEducationAsyncAction =
      AsyncAction('_ProfileStore.addEducation', context: context);

  @override
  Future<bool> addEducation(EducationEntity education) {
    return _$addEducationAsyncAction.run(() => super.addEducation(education));
  }

  late final _$updateEducationAsyncAction =
      AsyncAction('_ProfileStore.updateEducation', context: context);

  @override
  Future<bool> updateEducation(EducationEntity education) {
    return _$updateEducationAsyncAction
        .run(() => super.updateEducation(education));
  }

  late final _$deleteEducationAsyncAction =
      AsyncAction('_ProfileStore.deleteEducation', context: context);

  @override
  Future<bool> deleteEducation(String id) {
    return _$deleteEducationAsyncAction.run(() => super.deleteEducation(id));
  }

  late final _$loadExperiencesAsyncAction =
      AsyncAction('_ProfileStore.loadExperiences', context: context);

  @override
  Future<void> loadExperiences() {
    return _$loadExperiencesAsyncAction.run(() => super.loadExperiences());
  }

  late final _$addExperienceAsyncAction =
      AsyncAction('_ProfileStore.addExperience', context: context);

  @override
  Future<bool> addExperience(ExperienceEntity experience) {
    return _$addExperienceAsyncAction
        .run(() => super.addExperience(experience));
  }

  late final _$updateExperienceAsyncAction =
      AsyncAction('_ProfileStore.updateExperience', context: context);

  @override
  Future<bool> updateExperience(ExperienceEntity experience) {
    return _$updateExperienceAsyncAction
        .run(() => super.updateExperience(experience));
  }

  late final _$deleteExperienceAsyncAction =
      AsyncAction('_ProfileStore.deleteExperience', context: context);

  @override
  Future<bool> deleteExperience(String id) {
    return _$deleteExperienceAsyncAction.run(() => super.deleteExperience(id));
  }

  late final _$loadProjectsAsyncAction =
      AsyncAction('_ProfileStore.loadProjects', context: context);

  @override
  Future<void> loadProjects() {
    return _$loadProjectsAsyncAction.run(() => super.loadProjects());
  }

  late final _$addProjectAsyncAction =
      AsyncAction('_ProfileStore.addProject', context: context);

  @override
  Future<bool> addProject(ProjectEntity project) {
    return _$addProjectAsyncAction.run(() => super.addProject(project));
  }

  late final _$updateProjectAsyncAction =
      AsyncAction('_ProfileStore.updateProject', context: context);

  @override
  Future<bool> updateProject(ProjectEntity project) {
    return _$updateProjectAsyncAction.run(() => super.updateProject(project));
  }

  late final _$deleteProjectAsyncAction =
      AsyncAction('_ProfileStore.deleteProject', context: context);

  @override
  Future<bool> deleteProject(String id) {
    return _$deleteProjectAsyncAction.run(() => super.deleteProject(id));
  }

  late final _$loadAchievementsAsyncAction =
      AsyncAction('_ProfileStore.loadAchievements', context: context);

  @override
  Future<void> loadAchievements() {
    return _$loadAchievementsAsyncAction.run(() => super.loadAchievements());
  }

  late final _$addAchievementAsyncAction =
      AsyncAction('_ProfileStore.addAchievement', context: context);

  @override
  Future<bool> addAchievement(AchievementEntity achievement) {
    return _$addAchievementAsyncAction
        .run(() => super.addAchievement(achievement));
  }

  late final _$updateAchievementAsyncAction =
      AsyncAction('_ProfileStore.updateAchievement', context: context);

  @override
  Future<bool> updateAchievement(AchievementEntity achievement) {
    return _$updateAchievementAsyncAction
        .run(() => super.updateAchievement(achievement));
  }

  late final _$deleteAchievementAsyncAction =
      AsyncAction('_ProfileStore.deleteAchievement', context: context);

  @override
  Future<bool> deleteAchievement(String id) {
    return _$deleteAchievementAsyncAction
        .run(() => super.deleteAchievement(id));
  }

  late final _$addSkillAsyncAction =
      AsyncAction('_ProfileStore.addSkill', context: context);

  @override
  Future<bool> addSkill(String skill) {
    return _$addSkillAsyncAction.run(() => super.addSkill(skill));
  }

  late final _$removeSkillAsyncAction =
      AsyncAction('_ProfileStore.removeSkill', context: context);

  @override
  Future<bool> removeSkill(String skill) {
    return _$removeSkillAsyncAction.run(() => super.removeSkill(skill));
  }

  late final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore', context: context);

  @override
  void toggleEditMode() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.toggleEditMode');
    try {
      return super.toggleEditMode();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.clearError');
    try {
      return super.clearError();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEditMode: ${isEditMode},
profile: ${profile},
educations: ${educations},
experiences: ${experiences},
projects: ${projects},
achievements: ${achievements},
isLoadingProfile: ${isLoadingProfile},
isLoadingEducations: ${isLoadingEducations},
isLoadingExperiences: ${isLoadingExperiences},
isLoadingProjects: ${isLoadingProjects},
isLoadingAchievements: ${isLoadingAchievements},
isSaving: ${isSaving},
errorMessage: ${errorMessage},
isLoading: ${isLoading}
    ''';
  }
}
