import 'package:flutter/material.dart';
import 'package:find_job/auth/auth_routes.dart';
import 'package:find_job/auth/presentations/login/store/auth_store.dart';
import 'package:find_job/auth/presentations/signup/store/signup_store.dart';
import 'package:find_job/auth/presentations/signup/widgets/signup_form.dart';
import 'package:find_job/auth/presentations/widgets/auth_redirect_text.dart';
import 'package:find_job/auth/presentations/widgets/social_auth_buttons.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/nav/nav_helper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../data/repositories/auth_repository_impl.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                  "Create Account",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Create a new account to get started and enjoy",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const Text(
                  "seamless access to our features.",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 28),

                // Text fields
                SignUpForm(),

                const SizedBox(height: 20),

                AuthRedirectText(
                  promptText: "Already have an account?",
                  actionText: "Sign In here",
                  onTap: () => {NavHelper.goTo(context, AppRoutes.auth.login)},
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
