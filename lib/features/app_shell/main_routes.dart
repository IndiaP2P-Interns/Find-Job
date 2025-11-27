import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/features/home/demo_screen.dart';
import 'package:find_job/features/home/nav/home_routes.dart';
import 'package:find_job/features/home/presentation/views/screens/job_home_screen.dart';
import 'package:find_job/features/my_jobs/presentation/screens/my_jobs_screen.dart';
import 'package:find_job/features/profile/presentation/screens/profile_screen.dart';
import 'package:find_job/features/profile/profile_routes.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> mainRoutes = [
  GoRoute(
    path: AppRoutes.main.home,
    builder: (context, state) => const JobHomePage(),
    routes: [...homeRoutes],
  ),

  // My Jobs
  GoRoute(
    path: AppRoutes.main.myJobs,
    builder: (context, state) => const MyJobsScreen(),
  ),

  // Profile
  GoRoute(
    path: AppRoutes.main.profile,
    builder: (context, state) {
      final data = state.extra as Map?;
      final openEdit = data?["openInEditMode"] ?? false;

      return ProfileScreen(openInEditMode: openEdit);
    },
    routes: [...profileRoutes],
  ),
];
