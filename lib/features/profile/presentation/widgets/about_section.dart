import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/presentation/widgets/expandable_text.dart';

class AboutSectionEnhanced extends StatefulWidget {
  final ProfileStore store;

  const AboutSectionEnhanced({super.key, required this.store});

  @override
  State<AboutSectionEnhanced> createState() => _AboutSectionEnhancedState();
}

class _AboutSectionEnhancedState extends State<AboutSectionEnhanced> {
  late TextEditingController aboutController;

  @override
  void initState() {
    super.initState();
    aboutController = TextEditingController(text: widget.store.profile?.about ?? '');
  }

  @override
  void dispose() {
    aboutController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (widget.store.profile != null) {
      final updatedProfile = widget.store.profile!.copyWith(
        about: aboutController.text,
      );
      await widget.store.saveProfile(updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // Update controller when profile changes
        if (widget.store.profile != null && 
            aboutController.text != widget.store.profile!.about) {
          aboutController.text = widget.store.profile!.about;
        }

        final hasAbout = widget.store.profile?.about.isNotEmpty ?? false;

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
                        Icons.info_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'About',
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
                if (widget.store.isEditMode)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: aboutController,
                        maxLines: 5,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Tell us about yourself, your career goals, interests...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          filled: true,
                          fillColor: Colors.indigo.shade50.withOpacity(0.3),
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
                        ),
                      ),
                      const SizedBox(height: 16),
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
                          'Save About',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                else if (hasAbout)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.indigo.shade50.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.indigo.shade100,
                        width: 1,
                      ),
                    ),
                    child: ExpandableText(
                      text: widget.store.profile!.about,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.6,
                      ),
                    ),
                  )
                else
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No bio added yet',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
