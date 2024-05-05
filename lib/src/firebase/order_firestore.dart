import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/firestore.dart';
import 'package:qlqn/src/models/order.dart' as MyOrder;

class OrderFireStore implements Firestore<MyOrder.Order> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'Order'; // Tên của collection trong Firestore

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
  Future<Stream<List<MyOrder.Order>>> getAll() async {
    try {
      // Lắng nghe sự thay đổi trên collection 'Order'
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = _firestore.collection(_collection).snapshots();

      // Chuyển đổi dữ liệu từ các snapshot thành danh sách các đối tượng Order
      Stream<List<MyOrder.Order>> orderListStream = snapshots.map((snapshot) =>
          snapshot.docs.map((doc) => MyOrder.Order.fromFirestore(doc)).toList());

      return orderListStream;
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<MyOrder.Order> getById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection(_collection).doc(id).get();
      return MyOrder.Order.fromFirestore(doc);
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<void> insert(MyOrder.Order data) async {
    try {
      await _firestore.collection(_collection).add(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  @override
  Future<void> update(MyOrder.Order data) async {
    try {
      await _firestore.collection(_collection).doc(data.id).update(data.toJson());
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }
}
