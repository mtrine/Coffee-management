

import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  late final String _id;
  late final String _staffId;
  late final DateTime _orderDate;
  late final String _decription;

  Order(this._id, this._staffId, this._orderDate, this._decription);

  String get decription => _decription;

  set decription(String value) {
    _decription = value;
  }

  DateTime get orderDate => _orderDate;

  set orderDate(DateTime value) {
    _orderDate = value;
  }

  String get staffId => _staffId;

  set staffId(String value) {
    _staffId = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'staffId': _staffId,
      'orderDate': _orderDate,
      'description': _decription,
    };
  }

  // Phương thức tạo đối tượng Order từ một DocumentSnapshot
  static Order fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Order(
      doc.id,
      data['staffId'],
      (data['orderDate'] as Timestamp).toDate(),
      data['description'],
    );
  }
}