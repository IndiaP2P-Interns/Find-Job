import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/storage/onboarding_storage_service.dart';
import 'package:find_job/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnboardingStorageService _onboardingService = OnboardingStorageService();
  final SecureStorageService _authService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for splash screen to show for at least 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check authentication status first
    final accessToken = await _authService.getAccessToken();
    final isLoggedIn = accessToken != null && accessToken.isNotEmpty;

    if (isLoggedIn) {
    // if(true){
      // User is logged in, go directly to home
      context.go(AppRoutes.main.home);
      return;
    } else {
      // First-time user, show onboarding
      context.go(AppRoutes.onboarding.onboarding);
    }

    // User is not logged in, check onboarding status
   /* final hasCompletedOnboarding = await _onboardingService.hasCompletedOnboarding();

    if (!mounted) return;

    if (hasCompletedOnboarding) {
      // User has seen onboarding, go to login
      context.go(AppRoutes.auth.login);
    } else {
      // First-time user, show onboarding
      context.go(AppRoutes.onboarding.onboarding);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Text(
              'Find Job',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32),
            // CircularProgressIndicator(
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}
