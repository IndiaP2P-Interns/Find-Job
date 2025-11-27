import 'package:flutter/material.dart';
import 'package:find_job/core/utils/format_salary_tostring.dart';
import 'package:find_job/features/home/domain/model/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onApply;
  final VoidCallback onCardClick;
  final VoidCallback onSave; // added for save/bookmark button

  const JobCard({
    super.key,
    required this.job,
    required this.onApply,
    required this.onCardClick,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardClick, // whole card click
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(.05),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              "${formatSalaryRange(job.minSalary, job.maxSalary)} • ${job.employmentType}",
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(job.location, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 14),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.bookmark_border, color: Colors.grey[700]),
                  onPressed: onSave, // save/bookmark click
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
