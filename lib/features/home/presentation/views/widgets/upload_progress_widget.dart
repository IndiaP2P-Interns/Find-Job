// lib/features/home/presentation/widgets/upload_progress_widget.dart
import 'package:flutter/material.dart';

class UploadProgressWidget extends StatelessWidget {
  final String message;
  final int percent;
  const UploadProgressWidget({super.key, required this.message, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 8,
          child: LinearProgressIndicator(value: percent / 100),
        ),
        const SizedBox(height: 8),
        Text('$percent%'),
      ],
    );
  }
}
