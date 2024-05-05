import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetail{
  late final String _id;
  late final String _orderId;
  late final String _productId;
  late final int _quantity;

  OrderDetail(this._id, this._orderId, this._productId, this._quantity);

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  String get productId => _productId;

  set productId(String value) {
    _productId = value;
  }

  String get orderId => _orderId;

  set orderId(String value) {
    _orderId = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': _orderId,
      'productId': _productId,
      'quantity': _quantity,
    };
  }


  static OrderDetail fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return OrderDetail(
      doc.id,
      data['orderId'],
      data['productId'],
      data['quantity'],
    );
  }
}