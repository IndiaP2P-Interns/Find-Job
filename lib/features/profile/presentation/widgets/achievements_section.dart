import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/presentation/widgets/achievement_bottom_sheet.dart';
import 'package:find_job/features/profile/presentation/widgets/expandable_text.dart';

class AchievementsSectionEnhanced extends StatelessWidget {
  final ProfileStore store;

  const AchievementsSectionEnhanced({super.key, required this.store});

  void _showBottomSheet(BuildContext context, {dynamic achievement}) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AchievementBottomSheet(achievement: achievement),
      ),
    );

    if (result != null) {
      if (achievement == null) {
        await store.addAchievement(result);
      } else {
        await store.updateAchievement(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM dd, yyyy');

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
                      child: const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Achievements',
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
                if (store.achievements.isEmpty) ...[
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.emoji_events_outlined, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text(
                          store.isEditMode ? 'Tap + to add an achievement' : 'No achievements added yet',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  const SizedBox(height: 20),
                  ...store.achievements.map((achievement) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.indigo.shade50.withOpacity(0.3)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.indigo.shade100, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.amber.shade400, Colors.orange.shade500],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.emoji_events, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  achievement.title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              if (store.isEditMode) ...[
                                InkWell(
                                  onTap: () => _showBottomSheet(context, achievement: achievement),
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.indigo.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.edit_outlined, size: 18, color: Colors.indigo),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                InkWell(
                                  onTap: () async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        title: const Row(
                                          children: [
                                            Icon(Icons.warning_amber_rounded, color: Colors.orange),
                                            SizedBox(width: 12),
                                            Text('Delete Achievement'),
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
                                      await store.deleteAchievement(achievement.id);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 12),
                          ExpandableText(text: achievement.description, maxLines: 2),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today, size: 12, color: Colors.indigo.shade700),
                                const SizedBox(width: 6),
                                Text(
                                  dateFormatter.format(achievement.date),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.indigo.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
