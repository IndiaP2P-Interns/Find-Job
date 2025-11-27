import 'package:find_job/core/response_state.dart';
import 'package:find_job/features/home/domain/model/job.dart';

abstract class JobRepository {
  Future<Response<List<Job>>> fetchJobs({
    int page = 1,
    int pageSize = 20,
    String? query,
    Map<String, dynamic>? filters,
  });
  /// apply job: returns Success/ Error. onProgress gives step & percent
  Future<Response<void>> applyJob(String jobId, String filePath, {Function(String, int)? onProgress});
}
