
abstract class Firestore<T> {
  Future<void> insert(T data);
  Future<void> update(T data);
  Future<void> delete(String id);
  Future<Stream<List<T>>> getAll();
  Future<T> getById(String id);

}
