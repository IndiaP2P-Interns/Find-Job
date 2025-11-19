import 'package:flutter/material.dart';
import 'package:find_job/main/home/domain/model/job_filters.dart';
import 'package:find_job/main/home/presentation/views/widgets/job_filters/filter_trigger_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Color primary;
  final TextEditingController controller;
  final bool showFilters;
  final JobFilters filters;
  final VoidCallback toggleFilters;
  final void Function(String) onQueryChanged;
  final void Function(JobFilters) onFilterApplied;

  SearchBarDelegate(
    this.primary,
    this.controller,
    this.showFilters,
    this.filters,
    this.toggleFilters,
    this.onQueryChanged,
    this.onFilterApplied,
  );

  @override
  double get minExtent => showFilters ? 120 : 74;

  @override
  double get maxExtent => showFilters ? 120 : 74;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          _searchBar(primary),
          if (showFilters)
            FilterBar(
              filters: filters,
              onFilterApplied: (updatedFilters) {
                print("CALL API with => ${updatedFilters.toString()}");
                onFilterApplied(updatedFilters);
              },
            ),
        ],
      ),
    );
  }

  Widget _searchBar(Color primary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onQueryChanged,
                decoration: const InputDecoration(
                  hintText: 'Search for jobs...',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: toggleFilters, // <<<<<< ADD THIS
                child: Icon(Icons.tune, color: primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // there is no use of it now
  Widget _filterChips() {
    final filters = [
      "Date Posted",
      "Experience",
      "Remote",
      "Location",
      "Skill",
    ];
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: filters
            .map(
              (e) => Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  e,
                  style: GoogleFonts.inter(
                    color: Colors.indigo.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
