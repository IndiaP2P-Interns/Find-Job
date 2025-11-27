import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final String? errorText;
  final VoidCallback? onSuffixTap;
  final Function(String) onChanged;
  final bool showSuffix;

  const AuthTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.obscureText,
    required this.onChanged,
    this.errorText,
    this.onSuffixTap,
    this.showSuffix = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            prefixIcon: Icon(prefixIcon, color: Colors.grey[700]),
            suffixIcon: showSuffix
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[700],
                    ),
                  )
                : null,
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
        // if (errorText != null)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 4, left: 10),
        //     child: Text(
        //       errorText!,
        //       style: const TextStyle(color: Colors.red, fontSize: 12),
        //     ),
        //   ),
      ],
    );
  }
}
