import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return _dio.patch(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dio.delete(path);
  }
}
