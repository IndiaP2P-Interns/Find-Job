import 'package:find_job/core/utils/convert_string_to_date.dart';

class JobFilters {
  String? datePosted;
  String? employmentType;
  double minExp = 0;
  double maxExp = 20;
  double minSalary = 0;
  double maxSalary = 100;
  bool remote = false;
  String? location;
  List<String> skills = [];

  bool get isAnyApplied =>
      datePosted != null ||
      employmentType != null ||
      minExp > 0 ||
      maxExp < 20 ||
      minSalary > 0 ||
      maxSalary < 100 ||
      remote ||
      (location?.isNotEmpty ?? false) ||
      skills.isNotEmpty;

  JobFilters copy() {
    return JobFilters()
      ..datePosted = datePosted
      ..employmentType = employmentType
      ..minExp = minExp
      ..maxExp = maxExp
      ..minSalary = minSalary
      ..maxSalary = maxSalary
      ..remote = remote
      ..location = location
      ..skills = List.from(skills);
  }

  void resetSpecific(String filterType) {
    switch (filterType) {
      case "Date Posted":
        datePosted = null;
        break;

      case "Employment Type":
        employmentType = null;
        break;

      case "Experience":
        minExp = 0;
        maxExp = 20;
        break;

      case "Salary":
        minSalary = 0;
        maxSalary = 100;
        break;

      case "Remote":
        remote = false;
        break;

      case "Location":
        location = null;
        break;

      case "Skill":
        skills.clear();
        break;
    }
  }

  void reset() {
    datePosted = null;
    employmentType = null;
    minExp = 0;
    maxExp = 20;
    minSalary = 0;
    maxSalary = 100;
    remote = false;
    location = null;
    skills.clear();
  }
}

extension JobFiltersMapper on JobFilters {
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (datePosted != null) map["postedSince"] = datePostedToDate(datePosted);

    if (employmentType != null) {
      map["employmentType"] = employmentType!.toLowerCase();
    }

    if (minExp > 0) map["experienceMin"] = minExp;
    if (maxExp < 20) map["experienceMax"] = maxExp;

    if (minSalary > 0) map["minSalary"] = minSalary;
    if (maxSalary < 100) map["maxSalary"] = maxSalary;

    if (remote) map["remote"] = true;

    if (location != null && location!.isNotEmpty) {
      map["location"] = location!.trim().toLowerCase();
    }

    if (skills.isNotEmpty) map["skill"] = skills;

    return map;
  }
}
