sealed class AppRoutes {
  static final auth = _AuthRoutes();
  static final main = _MainRoutes();
  static final onboarding = _OnboardingRoutes();
}

class _AuthRoutes {
  final login = '/auth/login';
  final signup = '/auth/signup';
}

class _OnboardingRoutes {
  final onboarding = '/onboarding';
}

class _MainRoutes {
  final home = '/home';
  final myJobs = '/my_jobs';
  final profile = '/profile';
  final jobDetail = '/home/job_detail';
}

class _HomeRoutes {
  final allJobs = 'all_jobs';
  final jobDetail = 'job_detail';
}
