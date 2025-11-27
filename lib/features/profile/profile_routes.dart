import 'package:go_router/go_router.dart';
import 'package:find_job/features/profile/presentation/screens/profile_screen.dart';

final profileRoutes = [
  GoRoute(
    path: '/profile',
    name: 'profile',
    builder: (context, state) => const ProfileScreen(),
  ),
];
