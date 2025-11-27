import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 2,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  bool isOverflowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkOverflow();
  }

  @override
  void didUpdateWidget(covariant ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _checkOverflow();
    }
  }

  void _checkOverflow() {
    final style =
        widget.style ??
        TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.5);

    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: style),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );

    // Use actual available width
    final maxWidth = MediaQuery.of(context).size.width - 32;

    textPainter.layout(maxWidth: maxWidth);
    setState(() {
      isOverflowing = textPainter.didExceedMaxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text.trim().isEmpty) return const SizedBox.shrink();

    final style =
        widget.style ??
        TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: Text(
            widget.text,
            style: style,
            maxLines: isExpanded ? null : widget.maxLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),

        if (isOverflowing)
          GestureDetector(
            onTap: () {
              setState(() => isExpanded = !isExpanded);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isExpanded ? "Show less" : "Show more",
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.indigo.shade700,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
