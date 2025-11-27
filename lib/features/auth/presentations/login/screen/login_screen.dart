import 'package:find_job/features/auth/presentations/login/widgets/login_form.dart';
import 'package:find_job/features/auth/presentations/widgets/auth_background.dart';
import 'package:find_job/features/auth/presentations/widgets/auth_redirect_text.dart';
import 'package:find_job/features/auth/presentations/widgets/social_auth_buttons.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/nav/nav_helper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      title: 'Welcome Back',
      subtitle: 'Enter your email and password to securely access your account',
      child: Column(
        children: [
          const LoginForm(),
          const SizedBox(height: 32),
          AuthRedirectText(
            promptText: "Don't have an account?",
            actionText: "Sign Up here",
            onTap: () => {NavHelper.goTo(context, AppRoutes.auth.signup)},
          ),
          const SizedBox(height: 32),
          // const Row(
          //   children: [
          //     Expanded(child: Divider()),
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 16),
          //       child: Text(
          //         'OR',
          //         style: TextStyle(color: Colors.grey),
          //       ),
          //     ),
          //     Expanded(child: Divider()),
          //   ],
          // ),
          // const SizedBox(height: 32),
          SocialAuthOptions(),
        ],
      ),
    );
  }
}
