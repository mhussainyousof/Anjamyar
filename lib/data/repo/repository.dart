import 'package:flutter/material.dart';
import 'package:todolist/data/repo/source/source.dart';

class Repository<T> extends ChangeNotifier implements DataSource{
   final DataSource<T> dataSource;

  Repository(this.dataSource); 
  @override
  Future<void> createOrUpdate(data)async {
    final result = await dataSource.createOrUpdate(data);
    notifyListeners();
    return result;
  }

  @override
  Future<void> delete(data)async {
    dataSource.delete(data);
   notifyListeners();
  }

  @override
  Future<void> deleteAll()async {
     await dataSource.deleteAll();
     notifyListeners();
  }

  @override
  Future<void> deleteBy(Id)async {
     dataSource.deleteBy(Id); 
     notifyListeners();
  }

  @override
  Future findById(Id) {
   return dataSource.findById(Id);
  }

  @override
  Future<List<T>> getAll({String searchKeword = ''}) {
    return dataSource.getAll(searchKeword:searchKeword);
  }

}