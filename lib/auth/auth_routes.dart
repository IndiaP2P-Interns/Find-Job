import 'package:find_job/auth/presentations/login/screen/login_screen.dart';
import 'package:find_job/auth/presentations/signup/screen/signup_screen.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> authRoutes = [
  GoRoute(
    path: '/auth/login',
    name: AppRoutes.auth.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/auth/signup',
    name: AppRoutes.auth.signup,
    builder: (context, state) => const SignupScreen(),
  ),
  // GoRoute(
  //   path: 'forgot',
  //   name: AppRoutes.auth.forgotPassword,
  //   builder: (context, state) => const LoginScreen(),
  // ),
];
