import 'package:dio/dio.dart';
import 'package:find_job/core/network/dio_client.dart';

class JobRemoteDataSource {
  final DioClient client;
  JobRemoteDataSource(this.client);

  /// fetch jobs with pagination, search and filters
  Future<Response> fetchJobs({
    int page = 1,
    int pageSize = 20,
    String? query,
    Map<String, dynamic>? filters,
  }) {
    final qp = <String, dynamic>{'page': page, 'pageSize': pageSize};
    if (query != null && query.isNotEmpty) qp['q'] = query;
    if (filters != null) qp.addAll(filters);
    return client.get('/jobs', queryParams: qp);
  }

  Future<Response> applyJob(String jobId) {
    return client.post('/jobs/$jobId/apply', data: {});
  }
}
