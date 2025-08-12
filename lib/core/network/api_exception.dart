import 'package:dio/dio.dart';

class ApiException extends DioException {
  final String message;

  ApiException({required this.message, required super.requestOptions});

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(message: "Connection Timeout", requestOptions: error.requestOptions);
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Receive Timeout", requestOptions: error.requestOptions);
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        return ApiException(
          message: "Error: ${statusCode ?? 'Unknown'} - ${error.response?.data}",
          requestOptions: error.requestOptions,
        );
      default:
        return ApiException(message: error.message ?? "Unknown Error", requestOptions: error.requestOptions);
    }
  }
}
