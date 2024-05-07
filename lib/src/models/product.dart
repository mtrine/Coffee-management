
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late final String _id;
  late final String _name;
  late final int _unitPrice;
  late final String _imageUrl;
  late final DocumentReference _categoryId;

  Product(this._id, this._name, this._unitPrice, this._imageUrl, this._categoryId);


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  DocumentReference get categoryId => _categoryId;

  set categoryId(DocumentReference value) {
    _categoryId = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }


  int get unitPrice => _unitPrice;

  set unitPrice(int value) {
    _unitPrice = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'unitPrice': _unitPrice,
      'image_url': _imageUrl,
      'categoryId': _categoryId,
    };
  }

  static Product fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Product(
      doc.id,
      data['name'],
      data['unitPrice'],
      data['image_url'],
      data['categoryId'],
    );
  }
}