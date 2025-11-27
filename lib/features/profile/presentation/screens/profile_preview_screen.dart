import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/features/home/domain/model/job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/presentation/widgets/expandable_text.dart';
import 'package:find_job/features/profile/presentation/widgets/link_chip.dart';

class ProfilePreviewScreen extends StatefulWidget {
  final Job? jobData;

  const ProfilePreviewScreen({super.key, this.jobData});

  @override
  State<ProfilePreviewScreen> createState() => _ProfilePreviewScreenState();
}

class _ProfilePreviewScreenState extends State<ProfilePreviewScreen> {
  late final ProfileStore store;

  @override
  void initState() {
    super.initState();
    store = sl<ProfileStore>();
    store.initialize();
  }

  Future<void> _handleSubmit() async {
    // Check if resume exists
    if (store.profile?.resumePath == null ||
        store.profile!.resumePath!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.warning, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text('Please upload your resume before applying'),
                ),
              ],
            ),
            backgroundColor: Colors.orange.shade700,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Upload',
              textColor: Colors.white,
              onPressed: () {
                // navigate to profile in edit mode
                context.push(
                  AppRoutes.main.profile,
                  extra: {"openInEditMode": true},
                );
              },
            ),
          ),
        );
      }
      return;
    }

    // TODO: Implement actual job application logic
    // For now, just show success and navigate back
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Application submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true); // Return true to indicate submission
    }
  }

  void _handleEdit() {
    // Navigate to profile screen and enable edit mode
    context.push(AppRoutes.main.profile, extra: {"openInEditMode": true}).then((
      _,
    ) {
      // Reload profile after returning from edit
      store.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM yyyy');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Review Your Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Observer(
        builder: (_) {
          if (store.isLoading && store.profile == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Job Info Banner (if job data provided)
                if (widget.jobData != null)
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade600,
                          Colors.indigo.shade800,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.work, color: Colors.white, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Applying for',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                widget.jobData?.title ?? 'Job Position',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                // Info Message
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Review your profile before submitting. Tap Edit to make changes.',
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Basic Info
                _buildSection('Basic Information', Icons.person, [
                  _buildInfoRow('Name', store.profile?.name ?? 'Not provided'),
                  _buildInfoRow(
                    'Phone',
                    store.profile?.phone ?? 'Not provided',
                  ),
                  _buildInfoRow(
                    'Address',
                    store.profile?.address ?? 'Not provided',
                  ),
                ]),

                // Resume Section
                _buildResumeSection(),

                // About
                if (store.profile?.about.isNotEmpty ?? false)
                  _buildSection('About', Icons.info, [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ExpandableText(
                        text: store.profile!.about,
                        maxLines: 3,
                      ),
                    ),
                  ]),

                // Skills
                if (store.profile?.skills.isNotEmpty ?? false)
                  _buildSection('Skills', Icons.lightbulb, [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: store.profile!.skills
                          .map(
                            (skill) => Chip(
                              label: Text(skill),
                              backgroundColor: Colors.indigo.shade50,
                              labelStyle: TextStyle(
                                color: Colors.indigo.shade700,
                                fontSize: 12,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ]),

                // Education
                if (store.educations.isNotEmpty)
                  _buildSection(
                    'Education',
                    Icons.school,
                    store.educations.map((edu) {
                      return _buildTimelineCard(
                        edu.degree,
                        '${edu.institution} • ${edu.fieldOfStudy}',
                        dateFormatter.format(edu.startDate),
                        edu.endDate != null
                            ? dateFormatter.format(edu.endDate!)
                            : 'Present',
                        edu.bio,
                      );
                    }).toList(),
                  ),

                // Experience
                if (store.experiences.isNotEmpty)
                  _buildSection(
                    'Experience',
                    Icons.work,
                    store.experiences.map((exp) {
                      return _buildTimelineCard(
                        exp.position,
                        exp.company,
                        dateFormatter.format(exp.startDate),
                        exp.endDate != null
                            ? dateFormatter.format(exp.endDate!)
                            : 'Present',
                        exp.bio,
                      );
                    }).toList(),
                  ),

                // Projects
                if (store.projects.isNotEmpty)
                  _buildSection(
                    'Projects',
                    Icons.folder,
                    store.projects.map((project) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTimelineCard(
                            project.title,
                            project.description,
                            dateFormatter.format(project.startDate),
                            project.endDate != null
                                ? dateFormatter.format(project.endDate!)
                                : 'Present',
                            null,
                          ),
                          if (project.links.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project.links
                                  .map((link) => LinkChip(url: link))
                                  .toList(),
                            ),
                          ],
                        ],
                      );
                    }).toList(),
                  ),

                // Achievements
                if (store.achievements.isNotEmpty)
                  _buildSection(
                    'Achievements',
                    Icons.emoji_events,
                    store.achievements.map((achievement) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              achievement.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              achievement.description,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat(
                                'MMM dd, yyyy',
                              ).format(achievement.date),
                              style: TextStyle(
                                color: Colors.indigo.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 100), // Space for FABs
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _handleEdit,
            backgroundColor: Colors.white,
            foregroundColor: Colors.indigo,
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
            heroTag: 'edit',
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.black87,
            icon: const Icon(Icons.close),
            label: const Text('Cancel'),
            heroTag: 'cancel',
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: _handleSubmit,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.send),
            label: const Text('Submit Application'),
            heroTag: 'submit',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                    colors: [Colors.indigo.shade400, Colors.indigo.shade600],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(
    String title,
    String subtitle,
    String startDate,
    String endDate,
    String? bio,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$startDate - $endDate',
              style: TextStyle(
                fontSize: 11,
                color: Colors.indigo.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (bio != null && bio.isNotEmpty) ...[
            const SizedBox(height: 8),
            ExpandableText(text: bio, maxLines: 2),
          ],
        ],
      ),
    );
  }

  Widget _buildResumeSection() {
    final hasResume =
        store.profile?.resumePath != null &&
        store.profile!.resumePath!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                    colors: [Colors.indigo.shade400, Colors.indigo.shade600],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.description,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Resume',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (!hasResume) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Required',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          if (hasResume)
            InkWell(
              onTap: () async {
                try {
                  await OpenFilex.open(store.profile!.resumePath!);
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error opening resume: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.indigo.shade50,
                      Colors.indigo.shade100.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo.shade200, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red.shade400, Colors.red.shade600],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resume Uploaded',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tap to view PDF',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.indigo.shade700,
                      size: 16,
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.orange.shade700,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No Resume Uploaded',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Please upload your resume to apply',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
