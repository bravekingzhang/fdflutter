import '../entities/example_entity.dart';
import '../../data/repositories/example_repository.dart';

class GetExampleData {
  final ExampleRepository _repository;

  GetExampleData(this._repository);

  Future<ExampleEntity> call() async {
    final data = await _repository.getExampleData();
    return ExampleEntity(data ?? 'Default value');
  }
}
