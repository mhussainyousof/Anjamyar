part of 'task_list_bloc.dart';

@immutable
sealed class TaskListState {}

final class TaskListInitial extends TaskListState {}

final class TaskListLoading extends TaskListState {}

final class TaskListLoaded extends TaskListState {
final List<Task> items;

  TaskListLoaded(this.items);

}

class TaskListEmpty extends TaskListState{}

class TaskListError extends TaskListState {
  final String errorMessage;

  TaskListError({required this.errorMessage});
}