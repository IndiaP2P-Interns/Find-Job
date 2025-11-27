import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/nav/nav_helper.dart';
import 'package:find_job/features/my_jobs/presentation/widgets/applied_job_card.dart';
import 'package:find_job/features/my_jobs/presentation/widgets/saved_job_card.dart';
import 'package:find_job/features/my_jobs/store/my_jobs_store.dart';
import 'package:google_fonts/google_fonts.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MyJobsStore store = sl<MyJobsStore>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    store.fetchAppliedJobs();
    store.fetchSavedJobs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Jobs",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.indigo,
          labelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          tabs: const [
            Tab(text: "Applied"),
            Tab(text: "Saved"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppliedJobsList(),
          _buildSavedJobsList(),
        ],
      ),
    );
  }

  Widget _buildAppliedJobsList() {
    return Observer(
      builder: (_) {
        if (store.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (store.appliedJobs.isEmpty) {
          return _buildEmptyState("No applied jobs yet");
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: store.appliedJobs.length,
          itemBuilder: (context, index) {
            final job = store.appliedJobs[index];
            return AppliedJobCard(
              job: job,
              onTap: () {
                NavHelper.goToWithExtra(
                  context,
                  AppRoutes.main.jobDetail,
                  job,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSavedJobsList() {
    return Observer(
      builder: (_) {
        if (store.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (store.savedJobs.isEmpty) {
          return _buildEmptyState("No saved jobs yet");
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: store.savedJobs.length,
          itemBuilder: (context, index) {
            final job = store.savedJobs[index];
            return SavedJobCard(
              job: job,
              onTap: () {
                NavHelper.goToWithExtra(
                  context,
                  AppRoutes.main.jobDetail,
                  job,
                );
              },
              onApply: () {
                // TODO: Implement apply logic
                setState(() {
                  job.applied = true;
                });
              },
              onRemove: () {
                store.toggleSaveJob(job);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
