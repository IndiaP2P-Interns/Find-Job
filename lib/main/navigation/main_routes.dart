import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/main/home/demo_screen.dart';
import 'package:find_job/main/home/nav/home_routes.dart';
import 'package:find_job/main/home/presentation/views/screens/job_home_screen.dart';
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
    builder: (context, state) => const HomeScreen(),
  ),

  // Profile
  GoRoute(
    path: AppRoutes.main.profile,
    builder: (context, state) => const HomeScreen(),
  ),
];
