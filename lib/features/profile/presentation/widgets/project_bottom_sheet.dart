import 'package:flutter/material.dart';
import 'package:find_job/features/profile/domain/entities/project_entity.dart';
import 'package:find_job/features/profile/presentation/widgets/date_picker_field.dart';
import 'package:find_job/features/profile/presentation/widgets/link_chip.dart';

class ProjectBottomSheet extends StatefulWidget {
  final ProjectEntity? project;

  const ProjectBottomSheet({
    super.key,
    this.project,
  });

  @override
  State<ProjectBottomSheet> createState() => _ProjectBottomSheetState();
}

class _ProjectBottomSheetState extends State<ProjectBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController linkController;
  DateTime? startDate;
  DateTime? endDate;
  List<String> links = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.project?.title ?? '');
    descriptionController = TextEditingController(text: widget.project?.description ?? '');
    linkController = TextEditingController();
    startDate = widget.project?.startDate;
    endDate = widget.project?.endDate;
    links = List.from(widget.project?.links ?? []);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.project != null;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade600, Colors.indigo.shade800],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.folder, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    isEdit ? 'Edit Project' : 'Add Project',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    controller: titleController,
                    label: 'Project Title',
                    icon: Icons.title,
                    hint: 'e.g., E-commerce Platform',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: descriptionController,
                    label: 'Description',
                    icon: Icons.description,
                    hint: 'Describe your project...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  DatePickerField(
                    label: 'Start Date',
                    selectedDate: startDate,
                    onDateSelected: (date) => setState(() => startDate = date),
                    enabled: true,
                  ),
                  const SizedBox(height: 16),
                  DatePickerField(
                    label: 'End Date',
                    selectedDate: endDate,
                    onDateSelected: (date) => setState(() => endDate = date),
                    enabled: true,
                    isOptional: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Project Links',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: linkController,
                          decoration: InputDecoration(
                            hintText: 'https://...',
                            prefixIcon: const Icon(Icons.link, color: Colors.indigo),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.indigo, width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          if (linkController.text.isNotEmpty) {
                            setState(() {
                              links.add(linkController.text);
                              linkController.clear();
                            });
                          }
                        },
                        icon: const Icon(Icons.add_circle),
                        color: Colors.indigo,
                        iconSize: 32,
                      ),
                    ],
                  ),
                  if (links.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: links
                          .map((link) => LinkChip(
                                url: link,
                                showDelete: true,
                                onDelete: () => setState(() => links.remove(link)),
                              ))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      isEdit ? 'Update Project' : 'Add Project',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.indigo),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.indigo, width: 2),
        ),
      ),
    );
  }

  void _save() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final entity = ProjectEntity(
      id: widget.project?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      description: descriptionController.text,
      startDate: startDate!,
      endDate: endDate,
      links: links,
    );

    Navigator.pop(context, entity);
  }
}
