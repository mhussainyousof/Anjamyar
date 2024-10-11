abstract class Datasource<T>{
  Future<List<T>> getAll({String searchKeyword});
  Future<T> findById(dynamic Id);
  Future<void>deleteAll();
  Future<void>delete(T data);
  Future<void> deleteById(dynamic Id);
  Future<T> updateOrCreate(T data);
}