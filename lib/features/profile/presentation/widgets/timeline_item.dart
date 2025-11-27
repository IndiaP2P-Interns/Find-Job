import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final DateTime startDate;
  final DateTime? endDate;
  final String? bio;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isEditMode;
  final List<Widget>? additionalInfo;

  const TimelineItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.startDate,
    this.endDate,
    this.bio,
    this.onEdit,
    this.onDelete,
    this.isEditMode = false,
    this.additionalInfo,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM yyyy');
    final startDateStr = dateFormatter.format(startDate);
    final endDateStr = endDate != null ? dateFormatter.format(endDate!) : 'Present';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 60,
                color: Colors.indigo.shade100,
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.indigo.shade100,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isEditMode) ...[
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          color: Colors.indigo,
                          onPressed: onEdit,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          color: Colors.red,
                          onPressed: onDelete,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$startDateStr - $endDateStr',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.indigo.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (bio != null && bio!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      bio!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                  if (additionalInfo != null && additionalInfo!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ...additionalInfo!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
