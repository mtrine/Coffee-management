import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/firestore.dart';
import 'package:qlqn/src/models/orderDetail.dart';
import 'package:qlqn/src/models/product.dart';

class OrderDetailFireStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'OrderDetail'; // Tên của collection trong Firestore


  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }


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


  Future<OrderDetail> getById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection(_collection).doc(id).get();
      return OrderDetail.fromFirestore(doc);
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }

  Future<void> insert(OrderDetail data) async {
    try {
      await _firestore.collection(_collection).add({
        "orderId": data.orderId,
        "productId": data.productId,
        "quantity": data.quantity,
      }
      );
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
  Future<List<OrderDetail>> getListOrderDetailByOrderId(DocumentReference? orderId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collection).where('orderId', isEqualTo: orderId).get();
      print(querySnapshot.docs.length);
      List<OrderDetail> orderDetails = querySnapshot.docs.map((doc) {
        print(doc['orderId']);
        return OrderDetail(
          doc.id,
          doc['orderId'],
          doc['productId'],
          doc['quantity'],
        );
      }).toList();
      return orderDetails;
    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }
  Future<List<Product>> getProductById(List<OrderDetail> orderDetails) async {
    try {
      List<Product> products = [];
      for (OrderDetail orderDetail in orderDetails) {
        DocumentSnapshot<Object?> doc = await orderDetail.productId!.get();
        products.add(Product(
          doc.id,
          doc['name'],
          doc['unitPrice'],
          doc['image_url'],
          doc['categoryId'],
        ));
      }
      return products;

    } catch (e) {
      print("Error: $e");
      throw e; // Ném ngoại lệ để báo lỗi nếu có
    }
  }
}
