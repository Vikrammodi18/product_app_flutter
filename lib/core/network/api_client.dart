// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_tutorials/core/constant/api_endpoint.dart';
// import 'package:riverpod_tutorials/core/network/api_exception.dart';



// final dioProvider = Provider<Dio>((ref) {
//   final dio = Dio(
//     BaseOptions(
//       baseUrl: ApiEndpoint.baseUrl,
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 15),
//       headers: {'Content-Type': 'application/json'},
//     ),
//   );

//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) {
//         // Example: read token from Riverpod AuthProvider
//         final token = ref.read(authTokenProvider);
//         if (token != null && token.isNotEmpty) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         return handler.next(options);
//       },
//       onResponse: (response, handler) {
//         return handler.next(response);
//       },
//       onError: (DioException e, handler) {
//         final customError = ApiException.fromDioError(e);
//         handler.reject(customError);
//       },
//     ),
//   );

//   // Debug logs in dev mode
//   dio.interceptors.add(LogInterceptor(
//     requestBody: true,
//     responseBody: true,
//   ));

//   return dio;
// });
