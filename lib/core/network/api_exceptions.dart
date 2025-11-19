import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException("Connection timeout, please try again.");
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final msg =
            error.response?.data?['message'] ?? 'Unexpected server error.';
        return ApiException("Error $statusCode: $msg");
      case DioExceptionType.cancel:
        return ApiException("Request cancelled.");
      // case DioExceptionType.connectionError:
      //   return ApiException("No internet connection.");
      default:
        return ApiException("Something went wrong. Please try again later.");
    }
  }

  @override
  String toString() => message;
}
