import 'dart:io';

import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:find_job/features/home/data/datasource/job_remote_date_source.dart';
import 'package:find_job/features/home/domain/model/job.dart';
import 'package:find_job/features/home/domain/repositories/job_repositories.dart';
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

  /// APPLY FLOW: robust with per-step errors
  /// onProgress: (stepMessage, percent 0..100) => UI updates
  @override
  Future<Response<void>> applyJob(String jobId, String filePath, {Function(String, int)? onProgress}) async {
    if (!await networkInfo.isConnected) return Error("No internet connection");
    try {
      // Step 1: Request upload url
      onProgress?.call("Requesting upload URL...", 0);
      final applyRes = await remote.requestApply(jobId);
      final data = applyRes.data as Map<String, dynamic>?;

      if (data == null || data['uploadUrl'] == null || data['fileKey'] == null) {
        return Error("Invalid response from server");
      }

      final String uploadUrl = data['uploadUrl'] as String;
      final String fileKey = data['fileKey'] as String;

      // Step 2: Read file
      onProgress?.call("Reading file...", 1);
      final file = File(filePath);
      if (!file.existsSync()) return Error("Selected file not found");
      final fileLength = await file.length();
      final fileStream = file.openRead();

      // Step 3: Upload to S3 signed URL using Dio with progress
      onProgress?.call("Uploading resume...", 5);
      final dio = Dio();
      int sent = 0;

      await dio.put(
        uploadUrl,
        data: fileStream,
        options: Options(
          headers: {
            'Content-Type': 'application/pdf',
            // some S3 signed URLs may require additional headers — backend should provide
          },
          responseType: ResponseType.plain,
        ),
        onSendProgress: (count, total) {
          sent = count;
          final percent = total > 0 ? ((count / total) * 90).toInt() : 10;
          onProgress?.call("Uploading resume...", percent);
        },
      );

      onProgress?.call("Finalizing application...", 95);

      // Step 4: Confirm upload to backend
      await remote.confirmUpload(jobId, fileKey);

      onProgress?.call("Application completed", 100);
      return Success(null);
    } on ApiException catch (e) {
      return Error(e.message);
    } on DioException catch (e) {
      final msg = ApiException.fromDioError(e).message;
      return Error(msg);
    } catch (e) {
      return Error(e.toString());
    }
  }
}