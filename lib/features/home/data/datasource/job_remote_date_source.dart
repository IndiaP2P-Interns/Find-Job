// lib/features/home/data/datasource/job_remote_datasource.dart
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';

class JobRemoteDataSource {
  final DioClient client;
  JobRemoteDataSource(this.client);

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

  /// returns { uploadUrl, fileKey }
  Future<Response> requestApply(String jobId) {
    return client.post('/jobs/$jobId/apply');
  }

  /// notify backend that upload completed with fileKey (S3 path/key)
  Future<Response> confirmUpload(String jobId, String fileKey) {
    return client.post('/jobs/$jobId/confirm-upload', data: {'fileKey': fileKey});
  }
}
