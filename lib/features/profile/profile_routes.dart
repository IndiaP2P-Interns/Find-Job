import 'package:find_job/features/home/domain/model/job.dart';
import 'package:go_router/go_router.dart';
import 'package:find_job/features/profile/presentation/screens/profile_screen.dart';
import 'package:find_job/features/profile/presentation/screens/profile_preview_screen.dart';

final profileRoutes = [
  // GoRoute(
  //   path: '/profile',
  //   name: 'profile',
  //   builder: (context, state) => const ProfileScreen(),
  // ),
  GoRoute(
    path: 'preview_screen',
    builder: (context, state) {
      final jobData = state.extra as Job;
      return ProfilePreviewScreen(jobData: jobData);
    },
  ),
];
