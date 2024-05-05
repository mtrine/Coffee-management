import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/firestore.dart';
import 'package:qlqn/src/models/staff.dart';

class StaffFireStore implements Firestore<Staff> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'Staff'; // Tên của collection trong Firestore

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<Stream<List<Staff>>> getAll() async {
    try {
      // Lắng nghe sự thay đổi trên collection 'Staff'
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = _firestore.collection(_collection).snapshots();

      // Chuyển đổi dữ liệu từ các snapshot thành danh sách các đối tượng Staff
      Stream<List<Staff>> staffListStream = snapshots.map((snapshot) =>
          snapshot.docs.map((doc) => Staff.fromFirestore(doc)).toList());

      return staffListStream;
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<Staff> getById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection(_collection).doc(id).get();
      return Staff.fromFirestore(doc);
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<void> insert(Staff data) async {
    try {
      await _firestore.collection(_collection).add(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<void> update(Staff data) async {
    try {
      await _firestore.collection(_collection).doc(data.id).update(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }
}
