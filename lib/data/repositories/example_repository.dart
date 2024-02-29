import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';

class ExampleRepository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  ExampleRepository(this._localDataSource, this._remoteDataSource);

  Future<void> saveExampleData(String data) async {
    await _localDataSource.saveString('example_key', data);
  }

  Future<String?> getExampleData() async {
    return _localDataSource.getString('example_key');
  }

  Future<dynamic> fetchExampleData() async {
    return _remoteDataSource.fetchData('example_path');
  }

  // Add other methods as needed
}
