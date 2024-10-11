import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/source/source.dart';
import 'package:todolist/task.dart';

class HiveTaskSource implements Datasource<Task> {
   final Box<Task> box;
  HiveTaskSource(this.box);
  @override
  Future<void> delete(Task data) {
    return data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(Id) {
   return box.delete(Id);
  }

  @override
  Future<Task> findById(Id)async {
    return box.values.firstWhere((element)=>element.id == Id);
  }

  @override
  Future<List<Task>> getAll({String searchKeyword = ''}) async {
   if(searchKeyword.isNotEmpty){
    return box.values.where((element)=> element.name.contains(searchKeyword)).toList(); 
   }else{
   return box.values.toList();
   }
  }

  @override
  Future<Task> updateOrCreate(Task data)async {
   if(data.isInBox){
    data.save();
   }else{
    data.id = await box.add(data);
   }
   return data;
  }

}