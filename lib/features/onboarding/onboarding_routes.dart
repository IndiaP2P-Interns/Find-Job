import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/features/onboarding/presentation/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> onboardingRoutes = [
  GoRoute(
    path: '/onboarding',
    name: AppRoutes.onboarding.onboarding,
    builder: (context, state) => const OnboardingScreen(),
  ),
];
