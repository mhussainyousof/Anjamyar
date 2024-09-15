import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(1)
  String name = '';
  @HiveField(2)
  bool isCompleted = false;
  @HiveField(3)
  Priority? priority;
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(1)
  high,
  @HiveField(2)
  medium,
  @HiveField(3)
  low
}
