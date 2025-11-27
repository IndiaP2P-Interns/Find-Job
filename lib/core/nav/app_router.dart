
import 'package:find_job/features/app_shell/bottom_nav.dart';
import 'package:find_job/features/app_shell/main_routes.dart';
import 'package:find_job/features/app_shell/splash_screen.dart';
import 'package:find_job/features/auth/auth_routes.dart';
import 'package:find_job/features/onboarding/onboarding_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Splash route
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // Onboarding routes
    ...onboardingRoutes,

    // Auth routes
    ...authRoutes,

    // Main Shell with bottom nav
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        // Home
        ...mainRoutes,
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('404 - Page not found'))),
);
