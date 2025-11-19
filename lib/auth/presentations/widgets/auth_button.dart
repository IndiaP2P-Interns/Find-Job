import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String btnText;
  final bool isLoading;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.btnText,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: isLoading
          ? null
          : () {
              onPressed();
            },
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : const Text(
              "Login",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
    );
  }
}
