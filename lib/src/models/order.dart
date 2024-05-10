import 'package:cloud_firestore/cloud_firestore.dart';

class Orders{
  late final String _id;
  late final DocumentReference _staffId;
  late final Timestamp _orderDate;
  late final String _decription;
  late final int _total;

  Orders(
      this._id, this._staffId, this._orderDate, this._decription, this._total);

  int get total => _total;

  set total(int value) {
    _total = value;
  }

  String get decription => _decription;

  set decription(String value) {
    _decription = value;
  }


  DocumentReference get staffId => _staffId;

  set staffId(DocumentReference value) {
    _staffId = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Timestamp get orderDate => _orderDate;

  set orderDate(Timestamp value) {
    _orderDate = value;
  }
}