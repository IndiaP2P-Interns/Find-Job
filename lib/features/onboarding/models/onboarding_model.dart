class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static List<OnboardingModel> getOnboardingPages() {
    return [
      OnboardingModel(
        title: 'Find Your Dream Job',
        description:
            'Discover thousands of job opportunities that match your skills and interests.',
        imagePath: 'assets/images/onboarding_1.png',
      ),
      OnboardingModel(
        title: 'Easy Application Process',
        description:
            'Apply to multiple jobs with just a few taps. Track your applications in one place.',
        imagePath: 'assets/images/onboarding_2.png',
      ),
      OnboardingModel(
        title: 'Get Hired Faster',
        description:
            'Connect directly with employers and get instant notifications about your applications.',
        imagePath: 'assets/images/onboarding_3.png',
      ),
    ];
  }
}
