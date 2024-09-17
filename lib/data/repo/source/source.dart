abstract class DataSource<T> {
  Future<List<T>> getAll({String searchKeword});
  Future<T> findById(dynamic Id);
  Future<void> deleteAll();
  Future<void> delete(T data);
  Future<void> deleteBy(dynamic Id);
  Future<void> createOrUpdate(T data);
}
