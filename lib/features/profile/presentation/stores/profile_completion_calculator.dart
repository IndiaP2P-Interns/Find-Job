import 'package:mobx/mobx.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';

part 'profile_completion_calculator.g.dart';

class ProfileCompletionCalculator = _ProfileCompletionCalculator
    with _$ProfileCompletionCalculator;

abstract class _ProfileCompletionCalculator with Store {
  final ProfileStore profileStore;

  _ProfileCompletionCalculator(this.profileStore);

  @computed
  int get completionPercentage {
    if (profileStore.profile == null) return 0;

    int completed = 0;
    int total = 8; // Total sections

    // Basic details (name, phone, address) - 10%
    if (profileStore.profile!.name.isNotEmpty &&
        profileStore.profile!.phone.isNotEmpty &&
        profileStore.profile!.address.isNotEmpty) {
      completed++;
    }

    // Resume - 15%
    if (profileStore.profile!.resumePath != null &&
        profileStore.profile!.resumePath!.isNotEmpty) {
      completed++;
    }

    // About - 10%
    if (profileStore.profile!.about.isNotEmpty) {
      completed++;
    }

    // Skills - 10%
    if (profileStore.profile!.skills.isNotEmpty) {
      completed++;
    }

    // Education - 15%
    if (profileStore.educations.isNotEmpty) {
      completed++;
    }

    // Experience - 15%
    if (profileStore.experiences.isNotEmpty) {
      completed++;
    }

    // Projects - 15%
    if (profileStore.projects.isNotEmpty) {
      completed++;
    }

    // Achievements - 10%
    if (profileStore.achievements.isNotEmpty) {
      completed++;
    }

    return ((completed / total) * 100).round();
  }

  @computed
  String get completionMessage {
    final percentage = completionPercentage;
    if (percentage == 100) return 'Profile Complete! 🎉';
    if (percentage >= 75) return 'Almost there!';
    if (percentage >= 50) return 'Keep going!';
    if (percentage >= 25) return 'Good start!';
    return 'Let\'s build your profile';
  }
}
