import 'package:dio/dio.dart';
import 'package:find_job/core/storage/secure_storage_service.dart';

class TokenInterceptor extends Interceptor {
  final SecureStorageService storage;
  final Dio dio;

  TokenInterceptor(this.storage, this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await storage.getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] =
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTBmNDEwNmE2ZjY4ZDFhNjU4NDU2M2EiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzYyNjA3MzY2LCJleHAiOjE3NjI2MDgyNjZ9.ILbTSgjPeECmxSRYhedWI7Iz858-WbHSL_7q8vNFYi4';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Access token expired
      final refreshToken = await storage.getRefreshToken();

      if (refreshToken == null) {
        return handler.reject(err);
      }

      try {
        // Try refreshing
        final response = await dio.post(
          "auth/refresh",
          data: {"refresh_token": refreshToken},
        );

        final newAccessToken = response.data["access_token"];
        final newRefreshToken = response.data["refresh_token"];

        await storage.saveTokens(newAccessToken, newRefreshToken);

        // Retry original request
        final newRequest = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: {'Authorization': 'Bearer $newAccessToken'},
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(newRequest);
      } catch (e) {
        // Refresh failed → force logout
        await storage.clearTokens();
        return handler.reject(err);
      }
    }

    super.onError(err, handler);
  }
}
