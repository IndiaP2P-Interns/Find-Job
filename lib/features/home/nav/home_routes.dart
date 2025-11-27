import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/features/home/domain/model/job.dart';
import 'package:find_job/features/home/presentation/views/screens/job_detail_screen.dart';
import 'package:find_job/features/home/presentation/views/screens/job_home_screen.dart';

import 'package:go_router/go_router.dart';

final List<GoRoute> homeRoutes = [
  GoRoute(
    path: 'job_detail',
    builder: (context, state) {
      final job = state.extra as Job;
      return JobDetailScreen(job: job);
    },
  ),
];
