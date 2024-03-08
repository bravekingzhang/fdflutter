// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoEntityAdapter extends TypeAdapter<TodoEntity> {
  @override
  final int typeId = 0;

  @override
  TodoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoEntity(
      userId: fields[0] as int,
      id: fields[1] as int,
      title: fields[2] as String,
      completed: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TodoEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
