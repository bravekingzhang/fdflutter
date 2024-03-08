import 'package:hive/hive.dart';

part 'todo_entity.g.dart';

@HiveType(typeId: 0)
class TodoEntity extends HiveObject {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final bool completed;

  TodoEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
