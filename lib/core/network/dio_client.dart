import 'package:dio/dio.dart';
import 'package:find_job/core/network/api_exceptions.dart';
import 'package:find_job/core/network/token_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio, TokenInterceptor tokenInterceptor) {
    _dio
      ..options.baseUrl =
          //"https://7a8ee22b-b8ad-4e51-aecf-e9d63de1835b.mock.pstmn.io/api/"
          "http://43.204.39.44:5000/api/"
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..interceptors.addAll([
        tokenInterceptor,
        LogInterceptor(responseBody: true, requestBody: true),
      ]);
  }

  // Future<Response<T>> post<T>(String path, {dynamic data}) async {
  //   try {
  //     return await _dio.post<T>(path, data: data);
  //   } on DioException catch (e) {
  //     throw ApiException.fromDioError(e);
  //   }
  // }

  Future<Response<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? headers}) async { 
    try { 
      return await _dio.post<T>(path, data: data, options: Options(headers: headers)); 
      } on DioException catch (e) { 
        throw ApiException.fromDioError(e); 
      } 
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParams);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
