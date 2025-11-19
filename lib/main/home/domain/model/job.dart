class Job {
  final String id;
  final String title;
  final String description;
  final List<String> requiredSkills;
  final List<String> niceToHaveSkills;
  final String location;
  final bool isRemote;
  final String employmentType;
  final int minExperience;
  final int maxExperience;
  final int minSalary;
  final int maxSalary;
  final String salaryCurrency;
  final String company;
  final String companyLogoUrl;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int viewsCount;
  final int applicationsCount;
  bool applied; // Mutable for UI updates

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.requiredSkills,
    required this.niceToHaveSkills,
    required this.location,
    required this.isRemote,
    required this.employmentType,
    required this.minExperience,
    required this.maxExperience,
    required this.minSalary,
    required this.maxSalary,
    required this.salaryCurrency,
    required this.company,
    required this.companyLogoUrl,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    required this.viewsCount,
    required this.applicationsCount,
    this.applied = false,
  });

  factory Job.fromMap(Map<String, dynamic> json) {
    return Job(
      id: json['_id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      requiredSkills: (json['required_skills'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      niceToHaveSkills: (json['nice_to_have_skills'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      location: json['location'] ?? '',
      isRemote: json['remote'] == true,
      employmentType: json['employment_type'] ?? '',
      minExperience: json['experience_min'] ?? 0,
      maxExperience: json['experience_max'] ?? 0,
      minSalary: json['salary_range']?['min'] ?? 0,
      maxSalary: json['salary_range']?['max'] ?? 0,
      salaryCurrency: json['salary_range']?['currency'] ?? 'INR',
      company: json['created_by']?['name'] ?? 'Unknown',
      companyLogoUrl:
          json['companyLogoUrl'] ?? '', // optional, may not exist in API
      expiresAt: DateTime.tryParse(json['expires_at'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      viewsCount: json['views_count'] ?? 0,
      applicationsCount: json['applications_count'] ?? 0,
      applied: json['applied'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'required_skills': requiredSkills,
      'nice_to_have_skills': niceToHaveSkills,
      'location': location,
      'remote': isRemote,
      'employment_type': employmentType,
      'experience_min': minExperience,
      'experience_max': maxExperience,
      'salary_range': {
        'min': minSalary,
        'max': maxSalary,
        'currency': salaryCurrency,
      },
      'created_by': {'name': company},
      'companyLogoUrl': companyLogoUrl,
      'expires_at': expiresAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'views_count': viewsCount,
      'applications_count': applicationsCount,
      'applied': applied,
    };
  }
}
