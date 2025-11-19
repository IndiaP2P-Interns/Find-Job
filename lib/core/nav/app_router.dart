import 'package:find_job/auth/auth_routes.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/storage/secure_storage_service.dart';
import 'package:find_job/main/navigation/bottom_nav.dart';
import 'package:find_job/main/navigation/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main/home/presentation/views/screens/job_detail_screen.dart'
    show JobDetailScreen;

final SecureStorageService _storageService = SecureStorageService();

/*
final GoRouter appRouter = GoRouter(
  // Use a temporary splash route to check token
  initialLocation: '/main/home',

  routes: [
    //GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    ...authRoutes,
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [...mainRoutes],
    ),
  ],

  // The redirect logic
  // redirect: (context, state) async {
  //   // Avoid infinite loop when on splash
  //   if (state.uri.toString() == '/splash') {
  //     final token = await _storageService.getAccessToken();
  //     //return token == null ? AppRoutes.auth.login : AppRoutes.main.home;
  //     AppRoutes.main.home;
  //   }
  //   return null; // no redirect
  // },
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('404 - Page not found'))),
);
*/

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.main.home,
  routes: [
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
