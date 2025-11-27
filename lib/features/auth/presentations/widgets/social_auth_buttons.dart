import 'package:flutter/material.dart';

class SocialAuthOptions extends StatelessWidget {
  const SocialAuthOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1),
        const SizedBox(height: 15),
        const Text("Or Continue With Account"),
        const SizedBox(height: 15),
        const SocialLoginButtons(),
      ],
    );
  }
}

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircleButton(Icons.facebook, Colors.blue),
        const SizedBox(width: 20),
        _buildCircleButton(Icons.g_mobiledata, Colors.red),
        const SizedBox(width: 20),
        _buildCircleButton(Icons.apple, Colors.black),
      ],
    );
  }

  Widget _buildCircleButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: Icon(icon, color: color, size: 28),
    );
  }
}
