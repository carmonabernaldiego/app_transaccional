import 'package:dio/dio.dart';

class ApiClient {
  static const String baseUrl = 'https://apirxcheck.servehttp.com';
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> put(String path, {dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response> delete(String path, {Options? options}) {
    return _dio.delete(path, options: options);
  }

  void setToken(String token) {
    _dio.options.headers["Authorization"] = "Bearzer $token";
  }
}
