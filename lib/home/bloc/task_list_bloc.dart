import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todolist/data/repo/repository.dart';

import '../../task.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository<Task> repository;
  TaskListBloc(this.repository) : super(TaskListInitial()) {
    on<TaskListEvent>((event, emit)async {
    if(event is TaskListLoaded || event is TaskListSearch){

final String searchTerm;
      emit(TaskListLoading());
      await Future.delayed(Duration(seconds: 1));
      if (event is TaskListSearch) {
        searchTerm = event.query;
      }else{
        searchTerm = '';
      }
    try{
  final items = await repository.getAll(searchKeword: searchTerm);
      if (items.isNotEmpty){
        //! we use emit to return state to the view
        emit(TaskListLoaded(items));
      }else{
        emit(TaskListEmpty());
      }
    }catch(e){
      emit(TaskListError(errorMessage: 'نمیدونم چی مرگشه'));  
    }

    }else if (event is TaskListDeleteAll){
      await repository.deleteAll();
      emit(TaskListEmpty());
    }
      
    });
  }
}
