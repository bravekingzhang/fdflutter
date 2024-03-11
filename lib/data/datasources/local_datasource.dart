import 'package:fdflutter/domain/entities/todo_entity.dart';
import 'package:fdflutter/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataSource {
  static const keyTodoList = 'keyTodoList';
  static const keyUser = 'keyUser';
  Future<void> save(String key, value) async {
    var box = await Hive.openBox(key);

    await box.put(key, value); //todo ,这里的key需要是子项
  }

  Future get(String key, {defaultValue}) async {
    var box = await Hive.openBox(key);
    var value = box.get(key, defaultValue: defaultValue);
    return value;
  }

  // Add other methods for different data types as needed
}

initializeHive() async {
  // thanks  `亚·坤` for this suggestion
  var dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(TodoEntityAdapter())
    ..registerAdapter(UserAdapter());
}
