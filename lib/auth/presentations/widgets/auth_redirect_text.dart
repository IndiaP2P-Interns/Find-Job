import 'package:flutter/material.dart';

class AuthRedirectText extends StatelessWidget {
  final String promptText; // e.g. "Already have an account?"
  final String actionText; // e.g. "Sign In here"
  final VoidCallback onTap; // what happens when user taps the action text

  const AuthRedirectText({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(promptText, style: TextStyle(color: Colors.black87)),

        const SizedBox(width: 5),

        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Text(
            actionText,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
