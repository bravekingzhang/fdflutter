import '../../core/api/api_service.dart';

class RemoteDataSource {
  final ApiService _apiService;

  RemoteDataSource(this._apiService);

  Future<dynamic> fetchData(String path) async {
    final response = await _apiService.get(path);
    return response.data;
  }

  // Add other methods for different endpoints as needed
}
