import 'package:fdflutter/core/api/api_service.dart';

class RemoteDataSource {
  final ApiService _apiService;

  RemoteDataSource(this._apiService);

  Future fetchData(String path) async {
    final response = await _apiService.get(path);
    return response.data;
  }

  Future postData(String path, dynamic data) async {
    final response = await _apiService.post(path, data: data);
    return response.data;
  }

  Future putData(String path, dynamic data) async {
    final response = await _apiService.put(path, data: data);
    return response.data;
  }

  Future patchData(String path, dynamic data) async {
    final response = await _apiService.patch(path, data: data);
    return response.data;
  }

  Future deleteData(String path) async {
    final response = await _apiService.delete(path);
    return response.data;
  }
}
