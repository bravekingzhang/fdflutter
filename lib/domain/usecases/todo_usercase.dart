import 'package:fdflutter/core/utils/logger.dart';
import 'package:fdflutter/domain/entities/todo_entity.dart';
import 'package:fdflutter/data/repositories/todo_repository.dart';

class TodoUserCase {
  final _repository = TodoRepository();
  Future<List<TodoEntity>> loadTodoList() async {
    // first ,load from local
    var local = await _repository.loadTodoList();
    if (local.isNotEmpty) {
      logger.d('load from local success,there is ${local.length} data');
      return local;
    }
    logger.d('load from local failed,there is no data');
    // if not exist ,load from remote
    var remote = await _repository.fetchTodoList();
    logger.d('load from remote success');
    _repository.saveTodoList(remote);
    return remote;
  }
}
