import 'package:cloud_firestore/cloud_firestore.dart';

class Staff{
  late final String _id;
  late final String _fname;
  late final String _mname;
  late final String _lname;
  late final String _password;
  late final String _phone;

  Staff(this._id, this._fname, this._mname, this._lname, this._password, this._phone);

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get lname => _lname;

  set lname(String value) {
    _lname = value;
  }

  String get mname => _mname;

  set mname(String value) {
    _mname = value;
  }

  String get fname => _fname;

  set fname(String value) {
    _fname = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': _fname,
      'mname': _mname,
      'lname': _lname,
      'password': _password,
      'phone': _phone,
    };
  }

  static Staff fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Staff(
      doc.id,
      data['fname'],
      data['mname'],
      data['lname'],
      data['password'],
      data['phone'],
    );
  }
}