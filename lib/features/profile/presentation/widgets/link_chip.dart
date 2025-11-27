import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkChip extends StatelessWidget {
  final String url;
  final VoidCallback? onDelete;
  final bool showDelete;

  const LinkChip({
    super.key,
    required this.url,
    this.onDelete,
    this.showDelete = false,
  });

  Future<void> _launchUrl() async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchUrl,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.indigo.shade200, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.link, size: 16, color: Colors.indigo.shade700),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                url.length > 35 ? '${url.substring(0, 35)}...' : url,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showDelete) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.indigo.shade700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
