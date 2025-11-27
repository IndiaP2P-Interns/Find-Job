import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;
  final bool enabled;
  final bool isOptional;

  const DatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.enabled = true,
    this.isOptional = false,
  });

  Future<void> _selectDate(BuildContext context) async {
    if (!enabled) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.indigo,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  void _clearDate() {
    if (isOptional && enabled) {
      onDateSelected(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM dd, yyyy');
    final displayText = selectedDate != null
        ? dateFormatter.format(selectedDate!)
        : isOptional
            ? 'Present'
            : 'Select date';

    return InkWell(
      onTap: enabled ? () => _selectDate(context) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: enabled ? Colors.indigo.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: enabled ? Colors.indigo.shade200 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: enabled ? Colors.indigo : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: enabled ? Colors.black87 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            if (isOptional && selectedDate != null && enabled)
              IconButton(
                icon: const Icon(Icons.clear, size: 20),
                color: Colors.grey.shade600,
                onPressed: _clearDate,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}
