import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/presentation/widgets/simple_card_item.dart';
import 'package:find_job/features/profile/presentation/widgets/experience_bottom_sheet.dart';

class ExperienceSectionEnhanced extends StatelessWidget {
  final ProfileStore store;

  const ExperienceSectionEnhanced({super.key, required this.store});

  void _showBottomSheet(BuildContext context, {dynamic experience}) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ExperienceBottomSheet(experience: experience),
      ),
    );

    if (result != null) {
      if (experience == null) {
        await store.addExperience(result);
      } else {
        await store.updateExperience(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.indigo.shade400, Colors.indigo.shade600],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.work_outline, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Experience',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    if (store.isEditMode)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _showBottomSheet(context),
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, color: Colors.indigo.shade700, size: 24),
                          ),
                        ),
                      ),
                  ],
                ),
                if (store.experiences.isEmpty) ...[
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.work_outline, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text(
                          store.isEditMode ? 'Tap + to add your experience' : 'No experience added yet',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  const SizedBox(height: 20),
                  ...store.experiences.map((experience) {
                    return SimpleCardItem(
                      title: experience.position,
                      subtitle: experience.company,
                      startDate: experience.startDate,
                      endDate: experience.endDate,
                      bio: experience.bio,
                      icon: Icons.work,
                      isEditMode: store.isEditMode,
                      onEdit: () => _showBottomSheet(context, experience: experience),
                      onDelete: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            title: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                                SizedBox(width: 12),
                                Text('Delete Experience'),
                              ],
                            ),
                            content: const Text('Are you sure?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          await store.deleteExperience(experience.id);
                        }
                      },
                    );
                  }),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
