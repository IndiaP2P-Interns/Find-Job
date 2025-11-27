import 'package:flutter/material.dart';
import 'package:find_job/features/home/domain/model/job_filters.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  final String filterType;
  final JobFilters filters;

  const FilterBottomSheet({
    super.key,
    required this.filterType,
    required this.filters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late JobFilters temp; // local copy

  final locationCtrl = TextEditingController();
  final skillCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    temp = widget.filters.copy();
    locationCtrl.text = temp.location ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _sheetHandle(),

                  _header(),
                  const SizedBox(height: 12),
                  _buildFilterUI(),
                  const SizedBox(height: 24),
                  _applyButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetHandle() {
    return Container(
      width: 45,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Text(
          widget.filterType,
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              temp.resetSpecific(widget.filterType);
              locationCtrl.clear();
              skillCtrl.clear();
            });
          },
          child: Text(
            "Reset",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _applyButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 46),
        ),
        onPressed: () => Navigator.pop(context, temp),
        child: const Text("Apply"),
      ),
    );
  }

  Widget _buildFilterUI() {
    switch (widget.filterType) {
      case "Date Posted":
        return _datePosted();
      case "Employment Type":
        return _employmentType();
      case "Experience":
        return _exp();
      case "Salary":
        return _salary();
      case "Remote":
        return _remote();
      case "Location":
        return _location();
      case "Skill":
        return _skill();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _datePosted() {
    return Column(
      children: [
        _radioTile("Past 24 Hours", "24h", true),
        _radioTile("Past Week", "week", true),
        _radioTile("Past Month", "month", true),
      ],
    );
  }

  Widget _employmentType() {
    return Column(
      children: [
        _radioTile("Full Time", "full-time", false),
        _radioTile("Part Time", "part-time", false),
        _radioTile("Contract", "contract", false),
        _radioTile("Internship", "internship", false),
      ],
    );
  }

  Widget _radioTile(String title, String value, bool isDateTile) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: isDateTile ? temp.datePosted : temp.employmentType,
      onChanged: (v) => setState(
        () => isDateTile ? temp.datePosted = v : temp.employmentType = v,
      ),
    );
  }

  Widget _exp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${temp.minExp.toInt()} - ${temp.maxExp.toInt()} Years"),
        RangeSlider(
          min: 0,
          max: 20,
          activeColor: Colors.indigo,
          values: RangeValues(temp.minExp, temp.maxExp),
          onChanged: (v) =>
              setState(() => {temp.minExp = v.start, temp.maxExp = v.end}),
        ),
      ],
    );
  }

  Widget _salary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${temp.minSalary.toInt()}K - ${temp.maxSalary.toInt()}K"),
        RangeSlider(
          min: 0,
          max: 100,
          activeColor: Colors.indigo,
          values: RangeValues(temp.minSalary, temp.maxSalary),
          onChanged: (v) => setState(
            () => {temp.minSalary = v.start, temp.maxSalary = v.end},
          ),
        ),
      ],
    );
  }

  Widget _remote() {
    return SwitchListTile(
      activeThumbColor: Colors.indigo,
      value: temp.remote,
      onChanged: (v) => setState(() => temp.remote = v),
      title: const Text("Remote Only"),
    );
  }

  Widget _location() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: locationCtrl,
          onChanged: (v) => temp.location = v,
          decoration: InputDecoration(
            hintText: "Type location...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _skill() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: temp.skills
              .map(
                (s) => Chip(
                  label: Text(s),
                  onDeleted: () => setState(() => temp.skills.remove(s)),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: skillCtrl,
                decoration: InputDecoration(
                  hintText: "Add skill",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  final s = skillCtrl.text.trim();
                  if (s.isNotEmpty) {
                    setState(() => temp.skills.add(s));
                    skillCtrl.clear();
                  }
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
