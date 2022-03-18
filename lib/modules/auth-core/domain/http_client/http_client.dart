import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_example/modules/auth-core/domain/http_client/models/base_response_dto.dart';
import 'package:flutter_bloc_example/modules/auth-core/domain/http_client/models/error_response_dto.dart';

import 'http_defaulterror_parser.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

abstract class BaseDioClient {
  final String baseUrl;
  late Dio _dio;

  BaseDioClient({
    required this.baseUrl,
  }) {
    _dio = Dio();
    addDefaultOptions();
    addDefaultInterceptors();
  }

  Dio getClient();

  void addDefaultOptions() {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'X-DEVICE-BRAND': 'BRAND',
        'X-DEVICE-MODEL': 'MODEL',
        'X-DEVICE-OS': 'OS',
        'X-DEVICE-VERSION': 'VERSION',
        'X-DEVICE-TIMEZONE': 'TIMEZONE'
      };

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  void addDefaultInterceptors() {
    _dio.interceptors.addAll(
      [
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true,
        ),
        _generateResponseInterceptor(),
      ],
    );
  }

  InterceptorsWrapper _generateResponseInterceptor() {
    return InterceptorsWrapper(
      onResponse: (response, handler) {
        var normModel = BaseResponseDto.fromJson(
          response.data,
          (json) => Object,
        );
        if (normModel.success ?? true) {
          handler.next(response);
        } else {
          handler.reject(
            DioError(
              requestOptions: response.requestOptions,
              response: response,
              error: ErrorFromServer(
                ErrorResponseDto.fromJson(response.data).error?.text,
              ),
            ),
          );
        }
      },
      onError: (error, handler) {
        handler.reject(
          error,
        ); // Added this line to let error propagate outside the interceptor
      },
    );
  }
}

class AuthDioClient extends BaseDioClient {
  AuthDioClient({
    required String baseUrl,
  }) : super(baseUrl: baseUrl);

  @override
  Dio getClient() {
    return _dio;
  }
}

class AppDioClient extends BaseDioClient {
  final String token;
  final Function onUnauthenticated;

  AppDioClient({
    required String baseUrl,
    required this.token,
    required this.onUnauthenticated,
  }) : super(baseUrl: baseUrl);

  @override
  Dio getClient() {
    _dio.options.headers.addAll({
      'token': token,
    });
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, w) {
          if (e.response?.statusCode == 401) {
            onUnauthenticated();
          }
        },
      ),
    );
    return _dio;
  }
}
