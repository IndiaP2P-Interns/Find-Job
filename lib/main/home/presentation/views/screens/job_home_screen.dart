import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/nav/nav_helper.dart';
import 'package:find_job/main/home/presentation/views/screens/error_screen.dart';
import 'package:find_job/main/home/presentation/store/job_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../widgets/header_section.dart';
import '../widgets/search_bar_delegate.dart';
import '../widgets/job_card.dart';
import '../widgets/shimmer/shimmer_list.dart';

class JobHomePage extends StatefulWidget {
  const JobHomePage({super.key});

  @override
  State<JobHomePage> createState() => _JobHomePageState();
}

class _JobHomePageState extends State<JobHomePage> {
  final ScrollController _controller = ScrollController();
  final TextEditingController txtController = TextEditingController();
  final JobStore store = sl<JobStore>();

  @override
  void initState() {
    super.initState();

    store.fetchJobs(); // initial load

    _controller.addListener(() {
      if (_controller.position.pixels >
              _controller.position.maxScrollExtent - 300 &&
          !store.isLoading &&
          store.hasMore) {
        store.fetchJobs(loadMore: true);
      }
    });
  }

  Future<void> _refresh() async {
    await store.fetchJobs(); // refresh resets automatically inside store
  }

  @override
  Widget build(BuildContext context) {
    const primary = Colors.indigo;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[100],
        systemNavigationBarColor: Colors.grey[100],
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: RefreshIndicator(
            backgroundColor: Colors.grey[100],
            color: primary,
            onRefresh: _refresh,
            child: Observer(
              builder: (_) {
                return CustomScrollView(
                  controller: _controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // App Header
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Row(
                        children: const [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://i.pravatar.cc/150?img=12",
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Findr Jobs",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.notifications_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),

                    // top header
                    SliverToBoxAdapter(child: HeaderSection()),

                    // search bar + filter
                    SliverPersistentHeader(
                      floating: true,
                      delegate: SearchBarDelegate(
                        primary.shade600,
                        txtController,
                        store.showFilter,
                        store.filters,
                        store.toggleShowFilter,
                        (query) {
                          store.setSearchQuery(query);
                        },
                        (newFilters) {
                          store.setFilters(newFilters);
                        },
                      ),
                    ),

                    // If loading initial → show shimmer
                    if (store.isLoading && store.jobs.isEmpty)
                      const ShimmerList()
                    else if (store.showErrorState)
                      SliverToBoxAdapter(
                        child: ErrorView(
                          message: store.error!,
                          onRetry: () => store.fetchJobs(),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // loader at bottom
                            if (index == store.jobs.length) {
                              if (!store.hasMore) return const SizedBox();
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: primary,
                                  ),
                                ),
                              );
                            }

                            final job = store.jobs[index];
                            return JobCard(
                              job: job,
                              onCardClick: () {
                                // Navigate to job detail screen
                                NavHelper.goToWithExtra(
                                  context,
                                  AppRoutes.main.jobDetail,
                                  job,
                                );
                              },
                              onApply: () {
                                // setState(() {
                                //   myJob.applied = true; // mark applied
                                // });
                              },
                              onSave: () {
                                // Handle save/bookmark logic
                                //print('Saved job: ${myJob.title}');
                              },
                            );
                          },
                          childCount: store.hasMore
                              ? store.jobs.length + 1
                              : store.jobs.length,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
