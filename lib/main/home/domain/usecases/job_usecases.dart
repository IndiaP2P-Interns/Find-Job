import 'package:find_job/core/response_state.dart';
import 'package:find_job/main/home/domain/model/job.dart';
import 'package:find_job/main/home/domain/repositories/job_repositories.dart';

class JobUseCases {
  final JobRepository repository;
  JobUseCases(this.repository);

  Future<Response<List<Job>>> fetchJobs({
    int page = 1,
    int pageSize = 20,
    String? query,
    Map<String, dynamic>? filters,
  }) => repository.fetchJobs(
    page: page,
    pageSize: pageSize,
    query: query,
    filters: filters,
  );

  Future<Response<void>> applyJob(String jobId) => repository.applyJob(jobId);
}
