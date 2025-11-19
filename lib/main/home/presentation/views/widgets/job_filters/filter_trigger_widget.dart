import 'package:flutter/material.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/main/home/domain/model/job_filters.dart';
import 'package:find_job/main/navigation/store/navigation_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filter_bottom_sheet.dart';

class FilterBar extends StatefulWidget {
  final JobFilters filters;
  final void Function(JobFilters) onFilterApplied; // CALL API HERE

  const FilterBar({
    super.key,
    required this.filters,
    required this.onFilterApplied,
  });

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  final navStore = sl<NavigationStore>();
  final filterNames = [
    "Date Posted",
    "Employment Type",
    "Experience",
    "Salary",
    "Remote",
    "Location",
    "Skill",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // fixed height is required for horizontal ListView
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: filterNames.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          String name = filterNames[index];
          bool active = _isApplied(name);

          return GestureDetector(
            onTap: () {
              _openSheet(name);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: active ? Colors.indigo : Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                name,
                style: GoogleFonts.inter(
                  color: active ? Colors.white : Colors.indigo,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isApplied(String type) {
    final f = widget.filters;
    switch (type) {
      case "Date Posted":
        return f.datePosted != null;
      case "Employment Type":
        return f.employmentType != null;
      case "Experience":
        return f.minExp > 0 || f.maxExp < 20;
      case "Salary":
        return f.minSalary > 0 || f.maxSalary < 100;
      case "Remote":
        return f.remote;
      case "Location":
        return f.location?.isNotEmpty ?? false;
      case "Skill":
        return f.skills.isNotEmpty;
      default:
        return false;
    }
  }

  Future<void> _openSheet(String type) async {
    navStore.setBottomNavVisibility(false);

    final updated = await showModalBottomSheet<JobFilters>(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.grey[100],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) =>
          FilterBottomSheet(filterType: type, filters: widget.filters),
    );

    navStore.setBottomNavVisibility(true);

    if (updated != null) {
      setState(() {
        widget.filters
          ..datePosted = updated.datePosted
          ..employmentType = updated.employmentType
          ..minExp = updated.minExp
          ..maxExp = updated.maxExp
          ..minSalary = updated.minSalary
          ..maxSalary = updated.maxSalary
          ..remote = updated.remote
          ..location = updated.location
          ..skills = updated.skills;
      });

      widget.onFilterApplied(widget.filters); // <<<< call API
    }
  }
}
