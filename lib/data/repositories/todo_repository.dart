import 'package:fdflutter/core/api/api_service.dart';
import 'package:fdflutter/core/utils/logger.dart';
import 'package:fdflutter/domain/entities/todo_entity.dart';

import 'package:fdflutter/data/datasources/local_datasource.dart';
import 'package:fdflutter/data/datasources/remote_datasource.dart';
import 'package:get_it/get_it.dart';

class TodoRepository {
  final LocalDataSource _localDataSource = LocalDataSource();
  final RemoteDataSource _remoteDataSource =
      RemoteDataSource(GetIt.instance.get<ApiService>());

  Future<void> saveTodoList(List<TodoEntity> todos) async {
    await _localDataSource.save(LocalDataSource.keyTodoList, todos);
  }

  Future<List<TodoEntity>> loadTodoList() async {
    var localList = await _localDataSource
        .get(LocalDataSource.keyTodoList, defaultValue: []);
    return localList.cast<TodoEntity>();
  }

  Future<List<TodoEntity>> fetchTodoList() async {
    var datas = await _remoteDataSource.fetchData('/todos');
    datas = datas as List;
    return datas.map((e) => TodoEntity.fromJson(e)).toList();
  }
  // Add other methods for different data types as needed
}
