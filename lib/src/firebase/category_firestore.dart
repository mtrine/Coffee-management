import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/firestore.dart';
import 'package:qlqn/src/models/category.dart';

class CategoryFireStore implements Firestore<Categories> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'Category';

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  @override
  Future<Stream<List<Categories>>> getAll() async {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = _firestore.collection(_collection).snapshots();
      Stream<List<Categories>> categoryListStream = snapshots.map((snapshot) =>
          snapshot.docs.map((doc) => Categories.fromFirestore(doc)).toList());
      return categoryListStream;
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  @override
  Future<Categories> getById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection(_collection).doc(id).get();
      return Categories.fromFirestore(doc);
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  @override
  Future<void> insert(Categories data) async {
    try {
      await _firestore.collection(_collection).add(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  @override
  Future<void> update(Categories data) async {
    try {
      await _firestore.collection(_collection).doc(data.id).update(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }
}
