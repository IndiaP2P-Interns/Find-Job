import 'package:flutter/material.dart';
import 'package:find_job/features/profile/domain/entities/experience_entity.dart';
import 'package:find_job/features/profile/presentation/widgets/date_picker_field.dart';

class ExperienceBottomSheet extends StatefulWidget {
  final ExperienceEntity? experience;

  const ExperienceBottomSheet({
    super.key,
    this.experience,
  });

  @override
  State<ExperienceBottomSheet> createState() => _ExperienceBottomSheetState();
}

class _ExperienceBottomSheetState extends State<ExperienceBottomSheet> {
  late TextEditingController companyController;
  late TextEditingController positionController;
  late TextEditingController bioController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    companyController = TextEditingController(text: widget.experience?.company ?? '');
    positionController = TextEditingController(text: widget.experience?.position ?? '');
    bioController = TextEditingController(text: widget.experience?.bio ?? '');
    startDate = widget.experience?.startDate;
    endDate = widget.experience?.endDate;
  }

  @override
  void dispose() {
    companyController.dispose();
    positionController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.experience != null;

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
                  child: const Icon(Icons.work, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    isEdit ? 'Edit Experience' : 'Add Experience',
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
                    controller: companyController,
                    label: 'Company',
                    icon: Icons.business,
                    hint: 'e.g., Google Inc.',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: positionController,
                    label: 'Position',
                    icon: Icons.badge,
                    hint: 'e.g., Senior Software Engineer',
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
                    hint: 'Describe your role and achievements...',
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
                      isEdit ? 'Update Experience' : 'Add Experience',
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
    if (companyController.text.isEmpty ||
        positionController.text.isEmpty ||
        startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final entity = ExperienceEntity(
      id: widget.experience?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      company: companyController.text,
      position: positionController.text,
      startDate: startDate!,
      endDate: endDate,
      bio: bioController.text,
    );

    Navigator.pop(context, entity);
  }
}
