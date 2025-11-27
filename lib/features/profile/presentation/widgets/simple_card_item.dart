import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:find_job/features/profile/presentation/widgets/expandable_text.dart';

class SimpleCardItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final DateTime startDate;
  final DateTime? endDate;
  final String? bio;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isEditMode;
  final List<Widget>? additionalInfo;
  final IconData icon;

  const SimpleCardItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.startDate,
    this.endDate,
    this.bio,
    this.onEdit,
    this.onDelete,
    this.isEditMode = false,
    this.additionalInfo,
    this.icon = Icons.work_outline,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM yyyy');
    final startDateStr = dateFormatter.format(startDate);
    final endDateStr = endDate != null
        ? dateFormatter.format(endDate!)
        : 'Present';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.indigo.shade50.withOpacity(0.3)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.indigo.shade400, Colors.indigo.shade700],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 6),

                    if (subtitle != null && subtitle!.isNotEmpty)
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    else if (bio != null && bio!.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      ExpandableText(text: bio!, maxLines: 2),
                    ],
                  ],
                ),
              ),
              if (isEditMode) ...[
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.edit_outlined,
                  color: Colors.indigo,
                  onTap: onEdit,
                ),
                const SizedBox(width: 4),
                _buildActionButton(
                  icon: Icons.delete_outline,
                  color: Colors.red,
                  onTap: onDelete,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          // Date badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade50, Colors.indigo.shade100],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.indigo.shade200, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.indigo.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  '$startDateStr - $endDateStr',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (bio != null && bio!.isNotEmpty && subtitle != null) ...[
            const SizedBox(height: 14),
            ExpandableText(text: bio!, maxLines: 2),
          ],
          if (additionalInfo != null && additionalInfo!.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.only(top: 14),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: additionalInfo!,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
