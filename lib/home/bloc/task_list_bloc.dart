import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todolist/data/repo/repository.dart';
import 'package:todolist/task.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository<Task>repository;
  TaskListBloc(this.repository) : super(TaskListInitial()) {
    on<TaskListEvent>((event, emit) async{
      if(event is TaskListStarted || event is TaskListSearch){
        emit(TaskListLoading());
        await Future.delayed(Duration(seconds: 2));
        final String searchTerm;
        if(event is TaskListSearch){
         searchTerm = event.searchTerm;
        }else{
          searchTerm = '';
        }
        try{
          final items = await repository.getAll(searchKeyword: searchTerm);
          if(items.isNotEmpty){
            emit(TaskListSuccess(items));
          }else{
            emit(TaskListEmpty());
          }
        }catch(e){
          emit(TaskListError('خطای نا مشخص'));
        }
      }else if(event is TaskListDeletAll){
        await repository.deleteAll();
        emit(TaskListEmpty());
      }
    });
  }
}
