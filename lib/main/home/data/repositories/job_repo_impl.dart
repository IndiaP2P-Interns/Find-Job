import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:find_job/main/home/data/datasource/job_remote_date_source.dart';
import 'package:find_job/main/home/domain/model/job.dart';
import 'package:find_job/main/home/domain/repositories/job_repositories.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/response_state.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remote;
  final NetworkInfo networkInfo;

  JobRepositoryImpl(this.remote, this.networkInfo);

  @override
  Future<Response<List<Job>>> fetchJobs({
    int page = 1,
    int pageSize = 20,
    String? query,
    Map<String, dynamic>? filters,
  }) async {
    if (!await networkInfo.isConnected) return Error("No internet connection");
    try {
      final res = await remote.fetchJobs(
        page: page,
        pageSize: pageSize,
        query: query,
        filters: filters,
      );
      // expect backend: { data: { jobs: [...], total: 123 } }
      final body = res.data;
      final list = (body['data']?['jobs'] as List<dynamic>? ?? [])
          .map((e) => Job.fromMap(e as Map<String, dynamic>))
          .toList();

      debugPrint("[JobRepo] ✅ AllJobs response: $list");

      return Success(list);
    } on DioException catch (e) {
      debugPrint("[JobRepo] ✅ AllJobs response dio exception: $e");
      return Error(ApiException.fromDioError(e).message);
    } catch (e) {
      debugPrint("[JobRepo] ✅ AllJobs response error: $e");
      return Error(e.toString());
    }
  }

  @override
  Future<Response<void>> applyJob(String jobId) async {
    if (!await networkInfo.isConnected) return Error("No internet connection");
    try {
      final res = await remote.applyJob(jobId);
      // parse response and return success
      return Success(null);
    } on DioException catch (e) {
      return Error(ApiException.fromDioError(e).message);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
