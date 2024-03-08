import 'package:fdflutter/core/localization/config.dart';
import 'package:fdflutter/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:fdflutter/presentation/providers/todo_provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Page'),
      ),
      body: todoList.when(
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: todo.completed ? Colors.green : Colors.red,
                  child: Text(
                    todo.title[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  todo.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  todo.completed
                      ? AppLocale.competed.getString(context)
                      : AppLocale.notCompleted.getString(context),
                  style: TextStyle(
                      color: todo.completed ? Colors.green : Colors.red),
                ),
                trailing: Icon(
                  todo.completed ? Icons.check_circle : Icons.error,
                  color: todo.completed ? Colors.green : Colors.red,
                ),
              ),
            );
          },
        ),
        error: (error, stackTrace) {
          logger.e({'error': error, 'stackTrace': stackTrace});
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
