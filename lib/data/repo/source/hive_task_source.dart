import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/repo/source/source.dart';
import 'package:todolist/task.dart';

class HiveTaskDataSource implements DataSource<Task>{
  final Box<Task> box;

  HiveTaskDataSource(this.box);
  @override
  Future<Task> createOrUpdate(Task data)async {
    if(data.isInBox){
      data.save();
    }else{
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(Task data) {
  return  data.delete();
  }

  @override
  Future<void> deleteAll() {
   return box.clear();
  }

  @override
  Future<void> deleteBy(Id) {
    return box.delete(Id);
  }

  @override
  Future<Task> findById(Id)async {
   return box.values.firstWhere((element) => element.id == Id);
  }

  @override
  Future<List<Task>> getAll({String searchKeword = ''})async{
    if (searchKeword.isNotEmpty){
    return box.values.where((element)=> element.name.contains(searchKeword)).toList();

    }else{
      return box.values.toList();
    }
  }
}