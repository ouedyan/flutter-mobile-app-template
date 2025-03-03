import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../features/auth/data/auth_api_client.dart';
import '../../features/demo/data/demo_api_client.dart';

/// The API client
///
/// This class is meant to be seen as a representation of the common API contract
/// or API list (such as Swagger or Postman) given by the backend.
///
/// When a widget or provider wants to make a network request, it should not
/// instantiate this class, but instead call the provider that exposes an object
/// of this type.
class ApiClient {
  static final _defaultOptions = BaseOptions(baseUrl: 'https://dummyjson.com');

  static final List<Interceptor> _interceptors = [
    LogInterceptor(
      logPrint: (o) => debugPrint(o.toString()),
      responseBody: false,
      requestHeader: false,
      responseHeader: false,
    ),
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Do something before request is sent.
        // If you want to resolve the request with custom data,
        // you can resolve a `Response` using `handler.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject with a `DioException` using `handler.reject(dioError)`.
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Do something with response data.
        // If you want to reject the request with a error message,
        // you can reject a `DioException` object using `handler.reject(dioError)`.
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        // Do something with response error.
        // If you want to resolve the request with some custom data,
        // you can resolve a `Response` object using `handler.resolve(response)`.

        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (error.response != null) {
          debugPrint(
            'Dio ${error.requestOptions.method} error!\n'
            'STATUS: ${error.response!.statusCode}\n'
            'DATA: ${error.response!.data}',
          );
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          debugPrint(error.requestOptions.toString());
          debugPrint(error.message);
          if (error is SocketException) {
            debugPrint('${error.requestOptions.method} SocketException!');
          } else if (error is FormatException) {
            debugPrint('${error.requestOptions.method} FormatException!');
          } else {
            debugPrint('Error sending ${error.requestOptions.method} request!');
          }
        }

        return handler.next(error);
      },
    ),
  ];

  late final Dio _httpClient;
  late final AuthApiClient auth;
  late final DemoApiClient demo;

  /// Creates an [ApiClient] with default options.
  ApiClient() {
    _httpClient = Dio(_defaultOptions)..interceptors.addAll(_interceptors);
    _initializeApiClients();
  }

  /// Eg: Creates an [ApiClient] with [accessToken] set for authorization.
  // ApiClient.withToken(String accessToken) {
  //   _httpClient = Dio(
  //     _defaultOptions.copyWith()..headers['Authorization'] = 'Bearer $accessToken',
  //   )..interceptors.addAll(_interceptors);
  //   _initializeApiClients();
  // }

  void _initializeApiClients() {
    auth = AuthApiClient(_httpClient);
    demo = DemoApiClient(_httpClient);
  }
}
