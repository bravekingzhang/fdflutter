import 'dart:io';

import 'package:fdflutter/domain/entities/todo_entity.dart';
import 'package:hive/hive.dart';

class LocalDataSource {
  static const keyTodoList = 'keyTodoList';
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

initHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(TodoEntityAdapter());
}
