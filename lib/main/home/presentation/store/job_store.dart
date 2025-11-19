import 'dart:async';
import 'package:find_job/main/home/domain/model/job.dart';
import 'package:find_job/main/home/domain/model/job_filters.dart';
import 'package:find_job/main/home/domain/usecases/job_usecases.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/response_state.dart';

part 'job_store.g.dart';

class JobStore = _JobStore with _$JobStore;

abstract class _JobStore with Store {
  final JobUseCases useCases;

  _JobStore(this.useCases);

  // pagination
  @observable
  ObservableList<Job> jobs = ObservableList<Job>();

  @observable
  int page = 1;

  @observable
  bool hasMore = true;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  String searchQuery = '';

  @observable
  JobFilters filters = JobFilters();

  @observable
  bool showFilter = false;

  @computed
  bool get showErrorState => error != null && jobs.isEmpty;

  Timer? _searchDebounce;

  @action
  void setSearchQuery(String q) {
    searchQuery = q;
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      // new search -> reset
      page = 1;
      jobs.clear();
      hasMore = true;
      fetchJobs();
    });
  }

  @action
  void toggleShowFilter() {
    showFilter = !showFilter;
  }

  @action
  void setFilters(JobFilters f) {
    filters = f;
    page = 1;
    jobs.clear();
    hasMore = true;
    fetchJobs();
  }

  @action
  Future<void> fetchJobs({bool loadMore = false}) async {
    if (isLoading) return;
    if (!loadMore) {
      page = 1;
      jobs.clear();
      hasMore = true;
    }
    isLoading = true;
    error = null;
    final res = await useCases.fetchJobs(
      page: page,
      pageSize: 10,
      query: searchQuery,
      filters: filters.toMap(),
    );
    if (res is Success<List<Job>>) {
      final list = res.data;
      if (list.length < 10) hasMore = false;
      jobs.addAll(list);
      page++;
    } else if (res is Error<List<Job>>) {
      error = res.message;
    }
    isLoading = false;
  }

  @action
  Future<void> applyJob(String jobId) async {
    final jobIndex = jobs.indexWhere((j) => j.id == jobId);
    if (jobIndex == -1) return;
    // optimistic UI update
    jobs[jobIndex].applied = true;
    final res = await useCases.applyJob(jobId);
    if (res is Error<void>) {
      // rollback if failed
      jobs[jobIndex].applied = false;
      error = res.message;
    }
  }
}
