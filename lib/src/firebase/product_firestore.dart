import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/firestore.dart';
import 'package:qlqn/src/models/product.dart';
class ProductFireStore  {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'Product';


  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print("Error:"+e.toString());
    }
  }


  Future<List<Product>> getAllDocuments() async {
    List<Product> products = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collection).get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      for (var doc in documents) {
        // Xây dựng một đối tượng Product từ dữ liệu của mỗi tài liệu
        Product product = Product(doc.id, doc['name'], doc['unitPrice'], doc['image_url'], doc['categoryId']);

        products.add(product);
      }
    } catch (e) {
      print('Error getting documents: $e');
    }

    return products;
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

  Future<List<Product>> getByCategoryId(String categoryId) async {
    try {
      DocumentReference categoryRef = FirebaseFirestore.instance.collection('Category').doc(categoryId);
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection(_collection) // Thay thế 'your_collection' bằng tên của bảng dữ liệu sản phẩm của bạn
          .where('categoryId', isEqualTo: categoryRef)
          .get();

      // Chuyển đổi mỗi DocumentSnapshot thành một đối tượng Product
      List<Product> products = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data()!;

        return Product(
          doc.id,
          data['name'],
          data['unitPrice'].toInt(),
          data['image_url'],
          data['categoryId'],
        );
      }).toList();
      return products;
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }
  @override
  Future<void> insert(Product data) async {
    try {
      await _firestore.collection(_collection).add({
        'name': data.name,
        'unitPrice': data.unitPrice,
        'image_url': data.imageUrl,
        'categoryId': data.categoryId
      });
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