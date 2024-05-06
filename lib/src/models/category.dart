import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  late String _id;
  late String _name;
  late String _imageUrl;

  Categories(this._id, this._name, this._imageUrl);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'imageUrl': _imageUrl,
    };
  }

  static Categories fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Categories(
      doc.id,
      data['name'],
      data['imageUrl'],
    );
  }
}
