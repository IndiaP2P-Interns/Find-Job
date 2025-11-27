import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/presentation/stores/profile_completion_calculator.dart';
import 'package:find_job/features/profile/presentation/widgets/profile_header.dart';
import 'package:find_job/features/profile/presentation/widgets/resume_section.dart';
import 'package:find_job/features/profile/presentation/widgets/basic_details_section.dart';
import 'package:find_job/features/profile/presentation/widgets/about_section.dart';
import 'package:find_job/features/profile/presentation/widgets/education_section.dart';
import 'package:find_job/features/profile/presentation/widgets/experience_section.dart';
import 'package:find_job/features/profile/presentation/widgets/skills_section.dart';
import 'package:find_job/features/profile/presentation/widgets/projects_section.dart';
import 'package:find_job/features/profile/presentation/widgets/achievements_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileStore store;
  late final ProfileCompletionCalculator completionCalculator;

  @override
  void initState() {
    super.initState();
    store = sl<ProfileStore>();
    completionCalculator = ProfileCompletionCalculator(store);
    store.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Observer(
            builder: (_) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: store.isSaving
                    ? null
                    : () {
                        store.toggleEditMode();
                      },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    store.isEditMode ? Icons.check_circle : Icons.edit,
                    key: ValueKey(store.isEditMode),
                  ),
                ),
                tooltip: store.isEditMode ? 'Save' : 'Edit',
              ),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (store.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(store.errorMessage!),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'Dismiss',
                    textColor: Colors.white,
                    onPressed: () => store.clearError(),
                  ),
                ),
              );
              store.clearError();
            });
          }

          if (store.isLoading && store.profile == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          }

          return RefreshIndicator(
            color: Colors.indigo,
            onRefresh: () => store.initialize(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: AnimatedOpacity(
                opacity: store.isSaving ? 0.6 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  children: [
                    // Profile completion header
                    ProfileHeader(completionCalculator: completionCalculator),

                    const SizedBox(height: 8),

                    // Resume Section - Enhanced
                    ResumeSectionEnhanced(store: store),

                    const SizedBox(height: 8),

                    // Basic Details Section - Enhanced
                    BasicDetailsSectionEnhanced(store: store),

                    const SizedBox(height: 8),

                    // About Section - Enhanced
                    AboutSectionEnhanced(store: store),

                    const SizedBox(height: 8),

                    // Skills Section - Enhanced
                    SkillsSectionEnhanced(store: store),

                    const SizedBox(height: 8),

                    // Education Section - Enhanced
                    EducationSectionEnhanced(store: store),

                    const SizedBox(height: 8),

                    // Experience Section - Enhanced
                    ExperienceSectionEnhanced(store: store),

                    const SizedBox(height: 8),

                    // Projects Section - Enhanced
                    ProjectsSectionEnhanced(store: store),

                    const SizedBox(height: 8),

                    // Achievements Section - Enhanced
                    AchievementsSectionEnhanced(store: store),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
