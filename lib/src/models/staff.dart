import 'package:cloud_firestore/cloud_firestore.dart';

class Staff{
  late final String _id;
  late final String _fname;
  late final String _mlname;
  late final String _password;
  late final String _phone;
  late final String _address;
  late final String _dob;


  Staff(this._id, this._fname, this._mlname, this._password, this._phone,
      this._address, this._dob);


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'fName': _fname,
      'mlName': _mlname,
      'password': _password,
      'phone': _phone,
      'address': _address,
      'bDate': _dob,
    };
  }

  static Staff fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Staff(
      doc.id,
      data['fName'],
      data['mlName'],
      data['password'],
      data['phone'],
      data['address'],
      data['dob'],
    );
  }

  static Future<Staff?> getByPhone(String phone) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('Staff').where('phone', isEqualTo: phone).get();
      if (querySnapshot.docs.isNotEmpty) {
        return Staff(
          querySnapshot.docs.first.id,
          querySnapshot.docs.first['fName'],
          querySnapshot.docs.first['mlName'],
          querySnapshot.docs.first['password'],
          querySnapshot.docs.first['phone'],
          querySnapshot.docs.first['address'],
          querySnapshot.docs.first['bDate'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  String get fname => _fname;

  set fname(String value) {
    _fname = value;
  }

  String get mlname => _mlname;

  set mlname(String value) {
    _mlname = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get dob => _dob;

  set dob(String value) {
    _dob = value;
  }
}