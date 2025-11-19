import 'package:find_job/core/response_state.dart';
import 'package:find_job/main/home/domain/model/job.dart';

abstract class JobRepository {
  Future<Response<List<Job>>> fetchJobs({
    int page = 1,
    int pageSize = 20,
    String? query,
    Map<String, dynamic>? filters,
  });
  Future<Response<void>> applyJob(String jobId);
}
