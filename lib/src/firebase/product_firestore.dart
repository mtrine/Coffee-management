import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/firestore.dart';
import 'package:qlqn/src/models/product.dart';
class ProductFireStore implements Firestore<Product> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'Product';

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print("Error:"+e.toString());
    }
  }

  @override
  Future<Stream<List<Product>>> getAll() async {
    try {
      // Lắng nghe sự thay đổi trên collection 'Products'
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = _firestore.collection('Products').snapshots();

      // Chuyển đổi dữ liệu từ các snapshot thành danh sách các đối tượng Product
      Stream<List<Product>> productListStream = snapshots.map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());

      return productListStream;
    } catch (e) {
      print("Error: $e");
      // Ném ngoại lệ để thông báo lỗi nếu có
      throw e;
    }
  }

  @override
  Future<Product> getById(String id) {
    try{
      return _firestore.collection(_collection).doc(id).get().then((doc) => Product.fromFirestore(doc));
    } catch (e) {
      print("Error:"+e.toString());
      throw e;
    }
  }

  @override
  Future<void> insert(Product data) async {
    try {
      await _firestore.collection(_collection).add(data.toJson());
    } catch (e) {
      print("Error:"+e.toString());
    }
  }

  @override
  Future<void> update(Product data) async {
    try {
      await _firestore.collection(_collection).doc(data.id).update(data.toJson());
    } catch (e) {
      print("Error:"+e.toString());
    }
  }


}