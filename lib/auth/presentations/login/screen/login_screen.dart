import 'package:find_job/auth/presentations/login/widgets/login_form.dart';
import 'package:find_job/auth/presentations/widgets/auth_redirect_text.dart';
import 'package:find_job/auth/presentations/widgets/social_auth_buttons.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/nav/nav_helper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: Center(
        child: SingleChildScrollView(
          //padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Color(0xFFF2F3F7),
              //borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back, color: Colors.black54),
                const SizedBox(height: 20),
                const Text(
                  "Log in",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Enter your email and password to ",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const Text(
                  "securely aceess your account",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 28),

                const LoginForm(),

                const SizedBox(height: 20),

                AuthRedirectText(
                  promptText: "Don't have an account?",
                  actionText: "Sign Up here,",
                  onTap: () => {NavHelper.goTo(context, AppRoutes.auth.signup)},
                ),

                const SizedBox(height: 20),

                SocialAuthOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
