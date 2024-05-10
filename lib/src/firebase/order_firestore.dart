import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/models/order.dart' as MyOrder;

class OrderFireStore  {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'Order'; // Tên của collection trong Firestore

  Future<DocumentReference> insert(MyOrder.Orders data) async {
    return _firestore.collection(_collection).add({
      "staffId": data.staffId,
      "orderDate": data.orderDate,
      "decription": data.decription,
      "total": data.total,
    }
    );
  }
}
