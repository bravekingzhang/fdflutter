import 'package:fdflutter/domain/entities/todo_entity.dart';
import 'package:fdflutter/domain/usecases/todo_usercase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final todoListProvider =
    FutureProvider.autoDispose<List<TodoEntity>>((ref) async {
  final todoUserCase = TodoUserCase();
  return todoUserCase.loadTodoList();
});
