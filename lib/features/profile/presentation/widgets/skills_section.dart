import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';

class SkillsSectionEnhanced extends StatefulWidget {
  final ProfileStore store;

  const SkillsSectionEnhanced({super.key, required this.store});

  @override
  State<SkillsSectionEnhanced> createState() => _SkillsSectionEnhancedState();
}

class _SkillsSectionEnhancedState extends State<SkillsSectionEnhanced> {
  final TextEditingController _skillController = TextEditingController();

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  Future<void> _addSkill() async {
    if (_skillController.text.trim().isNotEmpty) {
      final success = await widget.store.addSkill(_skillController.text.trim());
      if (success) {
        _skillController.clear();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Skill added successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final skills = widget.store.profile?.skills ?? [];

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
                        Icons.lightbulb_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Skills',
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
                if (widget.store.isEditMode) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _skillController,
                          decoration: InputDecoration(
                            hintText: 'Add a skill',
                            prefixIcon: const Icon(Icons.add_circle_outline, color: Colors.indigo),
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
                              borderSide: const BorderSide(color: Colors.indigo, width: 2),
                            ),
                          ),
                          onSubmitted: (_) => _addSkill(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _addSkill,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.indigo.shade500, Colors.indigo.shade700],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (skills.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.store.isEditMode
                                ? 'Add your skills above'
                                : 'No skills added yet',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: skills.map((skill) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade50,
                                Colors.indigo.shade100.withOpacity(0.5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.indigo.shade200,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.shade700,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                skill,
                                style: TextStyle(
                                  color: Colors.indigo.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              if (widget.store.isEditMode) ...[
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () async {
                                    final success = await widget.store.removeSkill(skill);
                                    if (success && mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Removed "$skill"'),
                                          backgroundColor: Colors.orange,
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.indigo.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
