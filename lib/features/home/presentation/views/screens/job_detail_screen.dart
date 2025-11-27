import 'package:file_picker/file_picker.dart';
import 'package:find_job/features/home/presentation/store/apply_job_store.dart';
import 'package:find_job/features/home/presentation/views/widgets/upload_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/features/home/domain/model/job.dart';
import 'package:find_job/features/app_shell/store/navigation_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailScreen extends StatefulWidget {
  final Job job;
  const JobDetailScreen({super.key, required this.job});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  final navStore = sl<NavigationStore>();
  late final ApplyJobStore _applyStore;
  bool isScrolledDown = false;
  late AnimationController _buttonAnimationController;
  late Animation<Offset> _slideAnimation;
  bool expandDescription = false;
  final ScrollController _scrollController = ScrollController();

  SystemUiOverlayStyle get _currentStatusBarStyle {
    return SystemUiOverlayStyle(
      statusBarColor: isScrolledDown
          ? Colors.grey[100]
          : Colors.indigo.shade600,
      statusBarIconBrightness: isScrolledDown
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarColor: Colors.grey[100],
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  @override
  void initState() {
    super.initState();

    navStore.setBottomNavVisibility(false);

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );


     _applyStore = sl<ApplyJobStore>();

    _slideAnimation =
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, 0.5), // slides down when hiding
        ).animate(
          CurvedAnimation(
            parent: _buttonAnimationController,
            curve: Curves.easeInOut,
          ),
        );

    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !isScrolledDown) {
        setState(() => isScrolledDown = true);
        _buttonAnimationController.forward();
      } else if (_scrollController.offset <= 50 && isScrolledDown) {
        setState(() => isScrolledDown = false);
        _buttonAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    navStore.setBottomNavVisibility(true);
    _scrollController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _currentStatusBarStyle,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        extendBodyBehindAppBar: true, // important
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Top header with padding for status bar
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade600,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: _topHeader(job),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoSection(job),
                            const SizedBox(height: 20),
                            _skillsSection(job),
                            const SizedBox(height: 20),
                            _descriptionSection(job),
                            const SizedBox(height: 25),
                            _metricsSection(job),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Floating Apply Button
            _floatingApplyButton(job),
          ],
        ),
      ),
    );
  }

  Widget _topHeader(Job job) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 18, right: 18),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),

          // Title & optional location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(job.location, style: TextStyle(color: Colors.white70)),
                    if (job.isRemote)
                      Text(
                        "  • Remote",
                        style: TextStyle(
                          color: Colors.green.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Save / Bookmark icon
          IconButton(
            onPressed: () {
              // TODO: Save / Bookmark logic
            },
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  // ===== INFO SECTION =====
  Widget _infoSection(Job job) {
    return Column(
      children: [
        _infoCard(
          "Salary",
          "${job.salaryCurrency} ${job.minSalary} - ${job.maxSalary}",
          Icons.payments_outlined,
        ),
        const SizedBox(height: 14),
        _infoCard(
          "Experience",
          "${job.minExperience} - ${job.maxExperience} years",
          Icons.work_outline,
        ),
        const SizedBox(height: 14),
        _infoCard("Employment Type", job.employmentType, Icons.badge_outlined),
      ],
    );
  }

  // ===== SKILLS =====
  Widget _skillsSection(Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Required Skills",
          style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: job.requiredSkills
              .map((s) => _chip(s, Colors.indigo.shade50))
              .toList(),
        ),
        if (job.niceToHaveSkills.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(
            "Nice to Have Skills",
            style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: job.niceToHaveSkills
                .map((s) => _chip(s, Colors.green.shade50))
                .toList(),
          ),
        ],
      ],
    );
  }

  // ===== DESCRIPTION =====
  Widget _descriptionSection(Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job Description",
          style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            // Use TextPainter to detect overflow
            final textSpan = TextSpan(
              text: job.description,
              style: GoogleFonts.inter(fontSize: 15),
            );
            final textPainter = TextPainter(
              text: textSpan,
              maxLines: 4,
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth);

            final isOverflowing = textPainter.didExceedMaxLines;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.description,
                  maxLines: expandDescription ? null : 4,
                  overflow: expandDescription
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 15),
                ),
                if (isOverflowing)
                  GestureDetector(
                    onTap: () =>
                        setState(() => expandDescription = !expandDescription),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        expandDescription ? "Show less" : "Show more",
                        style: TextStyle(
                          color: Colors.indigo.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ===== METRICS =====
  Widget _metricsSection(Job job) {
    return Row(
      children: [
        Icon(Icons.remove_red_eye_outlined, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Text("${job.viewsCount} views"),
        const SizedBox(width: 20),
        Icon(Icons.person_outline, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Text("${job.applicationsCount} applications"),
      ],
    );
  }

/*
  Widget _floatingApplyButton(Job job) {
    return Positioned(
      bottom: 20 + MediaQuery.of(context).padding.bottom,
      left: 18,
      right: 18,
      child: SlideTransition(
        position: _slideAnimation,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isScrolledDown ? 0 : 1,
          child: ElevatedButton(
            onPressed: job.applied
                ? null
                : () {
                    setState(() => job.applied = true);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade600,
              disabledBackgroundColor: Colors.grey.shade400,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              job.applied ? "Already Applied" : "Apply Now",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
*/


Widget _floatingApplyButton(Job job) {
  return Positioned(
    bottom: 20 + MediaQuery.of(context).padding.bottom,
    left: 18,
    right: 18,
    child: SlideTransition(
      position: _slideAnimation,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isScrolledDown ? 0 : 1,
        child: Observer(
          builder: (_) {
            final applying = _applyStore.isApplying;
            final applied = job.applied;
            return ElevatedButton(
              onPressed: (applied || applying)
                  ? null
                  : () async {
                      // 1. pick file
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx'],
                      );
                      if (result == null) return;
                      final path = result.files.single.path;
                      if (path == null) return;

                      // optimistic UI: set applied true so user sees immediate change
                      setState(() => job.applied = true);

                      // run apply flow
                      _applyStore.apply(job.id, path);

                      // show modal with progress
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) {
                          return Observer(
                            builder: (_) {
                              if (_applyStore.error != null) {
                                // close modal and show error snackbar
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(_applyStore.error!),
                                    backgroundColor: Colors.red,
                                  ));
                                });
                                // rollback UI applied flag
                                setState(() => job.applied = false);
                                _applyStore.reset();
                                return const SizedBox.shrink();
                              }
                              if (!_applyStore.isApplying && _applyStore.progress == 100) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Application submitted successfully'),
                                    backgroundColor: Colors.green,
                                  ));
                                });
                                _applyStore.reset();
                                return const SizedBox.shrink();
                              }
                              return AlertDialog(
                                title: const Text('Uploading resume'),
                                content: UploadProgressWidget(
                                  message: _applyStore.statusMessage,
                                  percent: _applyStore.progress,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade600,
                disabledBackgroundColor: Colors.grey.shade400,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                job.applied ? "Already Applied" : ( _applyStore.isApplying ? "Applying..." : "Apply Now" ),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            );
          },
        ),
      ),
    ),
  );
}

  Widget _infoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo.shade600),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}
