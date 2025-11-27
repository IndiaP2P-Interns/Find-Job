import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/presentation/widgets/simple_card_item.dart';
import 'package:find_job/features/profile/presentation/widgets/project_bottom_sheet.dart';
import 'package:find_job/features/profile/presentation/widgets/link_chip.dart';

class ProjectsSectionEnhanced extends StatelessWidget {
  final ProfileStore store;

  const ProjectsSectionEnhanced({super.key, required this.store});

  void _showBottomSheet(BuildContext context, {dynamic project}) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ProjectBottomSheet(project: project),
      ),
    );

    if (result != null) {
      if (project == null) {
        await store.addProject(result);
      } else {
        await store.updateProject(result);
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
                          colors: [
                            Colors.indigo.shade400,
                            Colors.indigo.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.folder_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Projects',
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
                if (store.projects.isEmpty) ...[
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          store.isEditMode
                              ? 'Tap + to add a project'
                              : 'No projects added yet',
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
                  ...store.projects.map((project) {
                    return SimpleCardItem(
                      title: project.title,
                      startDate: project.startDate,
                      endDate: project.endDate,
                      bio: project.description,
                      icon: Icons.folder,
                      isEditMode: store.isEditMode,
                      onEdit: () => _showBottomSheet(context, project: project),
                      onDelete: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 12),
                                Text('Delete Project'),
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
                          await store.deleteProject(project.id);
                        }
                      },
                      additionalInfo: project.links.isNotEmpty
                          ? [
                              Text(
                                'Links',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: project.links
                                    .map((link) => LinkChip(url: link))
                                    .toList(),
                              ),
                            ]
                          : null,
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
