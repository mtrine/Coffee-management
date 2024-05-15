import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/models/order.dart' as MyOrder;

class OrderFireStore  {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'Orders'; // Tên của collection trong Firestore

  Future<DocumentReference> insert(MyOrder.Orders data) async {
    return _firestore.collection(_collection).add({
      "staffId": data.staffId,
      "orderDate": data.orderDate,
      "decription": data.decription,
      "total": data.total,
    }
    );
  }

  Future<List<MyOrder.Orders >> getAllDocument()async{
    List<MyOrder.Orders> products = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collection).get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      for (var doc in documents) {
        var data = doc.data() as Map<String, dynamic>; // Ép kiểu sang Map<String, dynamic>
        DocumentReference? staffIdRef = data['staffId'];
        MyOrder.Orders product = MyOrder.Orders(doc.id, staffIdRef!, data['orderDate'], data['decription'], data['total']);
        products.add(product);
      }
    } catch (e) {
      print('Error getting documents: $e');
      rethrow; // Rethrow để cho phép các phần khác của ứng dụng xử lý lỗi này nếu cần
    }

    return products;
  }

  Future<String?> getNameStaff(DocumentReference staffRef) async {
    DocumentSnapshot documentSnapshot = await staffRef.get();
    var data = documentSnapshot.data() as Map<String, dynamic>?;
    String? name= data?['fName']+" "+data?['mlName'];
    return name;
  }

}
