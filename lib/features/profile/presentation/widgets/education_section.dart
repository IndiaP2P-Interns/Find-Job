import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/presentation/widgets/simple_card_item.dart';
import 'package:find_job/features/profile/presentation/widgets/education_bottom_sheet.dart';

class EducationSectionEnhanced extends StatelessWidget {
  final ProfileStore store;

  const EducationSectionEnhanced({super.key, required this.store});

  void _showBottomSheet(BuildContext context, {dynamic education}) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EducationBottomSheet(education: education),
      ),
    );

    if (result != null) {
      if (education == null) {
        await store.addEducation(result);
      } else {
        await store.updateEducation(result);
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
                      child: const Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Education',
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
                            child: Icon(
                              Icons.add,
                              color: Colors.indigo.shade700,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (store.educations.isEmpty) ...[
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          store.isEditMode 
                              ? 'Tap + to add your education' 
                              : 'No education added yet',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  const SizedBox(height: 20),
                  ...store.educations.map((education) {
                    return SimpleCardItem(
                      title: education.degree,
                      subtitle: '${education.institution} • ${education.fieldOfStudy}',
                      startDate: education.startDate,
                      endDate: education.endDate,
                      bio: education.bio,
                      icon: Icons.school,
                      isEditMode: store.isEditMode,
                      onEdit: () => _showBottomSheet(context, education: education),
                      onDelete: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                                SizedBox(width: 12),
                                Text('Delete Education'),
                              ],
                            ),
                            content: const Text(
                              'Are you sure you want to delete this education entry?',
                            ),
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
                          await store.deleteEducation(education.id);
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
