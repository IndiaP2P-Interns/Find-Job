import 'package:flutter/material.dart';
import 'package:find_job/features/auth/presentations/signup/widgets/signup_form.dart';
import 'package:find_job/features/auth/presentations/widgets/auth_background.dart';
import 'package:find_job/features/auth/presentations/widgets/auth_redirect_text.dart';
import 'package:find_job/features/auth/presentations/widgets/social_auth_buttons.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/nav/nav_helper.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      title: 'Create Account',
      subtitle: 'Create a new account to get started and enjoy seamless access to our features',
      child: Column(
        children: [
          const SignUpForm(),
          const SizedBox(height: 32),
          AuthRedirectText(
            promptText: "Already have an account?",
            actionText: "Sign In here",
            onTap: () => {NavHelper.goTo(context, AppRoutes.auth.login)},
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
          //const SizedBox(height: 32),
          SocialAuthOptions(),
        ],
      ),
    );
  }
}
