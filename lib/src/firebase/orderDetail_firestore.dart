import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/firestore.dart';
import 'package:qlqn/src/models/orderDetail.dart';

class OrderDetailFireStore implements Firestore<OrderDetail> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'OrderDetail'; // Tên của collection trong Firestore

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
  Future<Stream<List<OrderDetail>>> getAll() async {
    try {
      // Lắng nghe sự thay đổi trên collection 'OrderDetail'
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = _firestore.collection(_collection).snapshots();

      // Chuyển đổi dữ liệu từ các snapshot thành danh sách các đối tượng OrderDetail
      Stream<List<OrderDetail>> orderDetailListStream = snapshots.map((snapshot) =>
          snapshot.docs.map((doc) => OrderDetail.fromFirestore(doc)).toList());

      return orderDetailListStream;
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<OrderDetail> getById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection(_collection).doc(id).get();
      return OrderDetail.fromFirestore(doc);
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<void> insert(OrderDetail data) async {
    try {
      await _firestore.collection(_collection).add(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<void> update(OrderDetail data) async {
    try {
      await _firestore.collection(_collection).doc(data.id).update(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }
}
