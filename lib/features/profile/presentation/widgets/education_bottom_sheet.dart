import 'package:flutter/material.dart';
import 'package:find_job/features/profile/domain/entities/education_entity.dart';
import 'package:find_job/features/profile/presentation/widgets/date_picker_field.dart';

class EducationBottomSheet extends StatefulWidget {
  final EducationEntity? education;

  const EducationBottomSheet({
    super.key,
    this.education,
  });

  @override
  State<EducationBottomSheet> createState() => _EducationBottomSheetState();
}

class _EducationBottomSheetState extends State<EducationBottomSheet> {
  late TextEditingController institutionController;
  late TextEditingController degreeController;
  late TextEditingController fieldController;
  late TextEditingController bioController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    institutionController = TextEditingController(text: widget.education?.institution ?? '');
    degreeController = TextEditingController(text: widget.education?.degree ?? '');
    fieldController = TextEditingController(text: widget.education?.fieldOfStudy ?? '');
    bioController = TextEditingController(text: widget.education?.bio ?? '');
    startDate = widget.education?.startDate;
    endDate = widget.education?.endDate;
  }

  @override
  void dispose() {
    institutionController.dispose();
    degreeController.dispose();
    fieldController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.education != null;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
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
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    isEdit ? 'Edit Education' : 'Add Education',
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
          // Form content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    controller: institutionController,
                    label: 'Institution',
                    icon: Icons.location_city,
                    hint: 'e.g., Harvard University',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: degreeController,
                    label: 'Degree',
                    icon: Icons.workspace_premium,
                    hint: 'e.g., Bachelor of Science',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: fieldController,
                    label: 'Field of Study',
                    icon: Icons.book,
                    hint: 'e.g., Computer Science',
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
                  _buildTextField(
                    controller: bioController,
                    label: 'Bio (Optional)',
                    icon: Icons.subject,
                    hint: 'Describe your experience...',
                    maxLines: 4,
                  ),
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
                      isEdit ? 'Update Education' : 'Add Education',
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
    if (institutionController.text.isEmpty ||
        degreeController.text.isEmpty ||
        fieldController.text.isEmpty ||
        startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final entity = EducationEntity(
      id: widget.education?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      institution: institutionController.text,
      degree: degreeController.text,
      fieldOfStudy: fieldController.text,
      startDate: startDate!,
      endDate: endDate,
      bio: bioController.text,
    );

    Navigator.pop(context, entity);
  }
}
