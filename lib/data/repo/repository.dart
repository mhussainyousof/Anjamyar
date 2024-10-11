import 'package:flutter/material.dart';
import 'package:todolist/data/source/source.dart';

class Repository<T> extends ChangeNotifier implements Datasource<T>{
  final Datasource<T> datasource;

  Repository(this.datasource);
  @override
  Future<void> delete(T data) async{
    datasource.delete(data);
    notifyListeners();
  }

  @override
  Future<void> deleteAll() async{
   await  datasource.deleteAll();
     notifyListeners();
  }

  @override
  Future<void> deleteById(Id) async{
   datasource.deleteById(Id);
   notifyListeners();
  }

  @override
  Future<T> findById(Id) {
    return datasource.findById(Id);
  }

  @override
  Future<List<T>> getAll({String searchKeyword = ''}) {
    return datasource.getAll(searchKeyword: searchKeyword);
  }

  @override
  Future<T> updateOrCreate(T data)async {
      final T result = await datasource.updateOrCreate(data);
      notifyListeners();
      return result;
  }

}