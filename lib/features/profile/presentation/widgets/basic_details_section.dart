import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';

class BasicDetailsSectionEnhanced extends StatefulWidget {
  final ProfileStore store;

  const BasicDetailsSectionEnhanced({super.key, required this.store});

  @override
  State<BasicDetailsSectionEnhanced> createState() => _BasicDetailsSectionEnhancedState();
}

class _BasicDetailsSectionEnhancedState extends State<BasicDetailsSectionEnhanced> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.store.profile?.name ?? '');
    phoneController = TextEditingController(text: widget.store.profile?.phone ?? '');
    addressController = TextEditingController(text: widget.store.profile?.address ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (widget.store.profile != null) {
      final updatedProfile = widget.store.profile!.copyWith(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
      );
      await widget.store.saveProfile(updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // Update controllers when profile changes
        if (widget.store.profile != null) {
          if (nameController.text != widget.store.profile!.name) {
            nameController.text = widget.store.profile!.name;
          }
          if (phoneController.text != widget.store.profile!.phone) {
            phoneController.text = widget.store.profile!.phone;
          }
          if (addressController.text != widget.store.profile!.address) {
            addressController.text = widget.store.profile!.address;
          }
        }

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        Icons.person_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Basic Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: nameController,
                  label: 'Full Name',
                  icon: Icons.badge_outlined,
                  hint: 'Enter your name',
                  enabled: widget.store.isEditMode,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  hint: '+91 XXXXX XXXXX',
                  enabled: widget.store.isEditMode,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: addressController,
                  label: 'Address',
                  icon: Icons.location_on_outlined,
                  hint: 'Enter your address',
                  enabled: widget.store.isEditMode,
                  maxLines: 2,
                ),
                if (widget.store.isEditMode) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Save Details',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    required bool enabled,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 15,
        color: enabled ? Colors.black87 : Colors.grey.shade700,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: enabled ? Colors.indigo : Colors.grey.shade500,
          size: 22,
        ),
        filled: true,
        fillColor: enabled ? Colors.indigo.shade50.withOpacity(0.3) : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.indigo.shade100, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.indigo, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
    );
  }
}
