part of 'task_list_bloc.dart';

@immutable
sealed class TaskListEvent {}


class TaskListStarted extends TaskListEvent{}

class TaskListDeletAll extends TaskListEvent{}
class TaskListSearch extends TaskListEvent{
  final String searchTerm;
TaskListSearch(this.searchTerm);}
