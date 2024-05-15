import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/staff_firestore.dart';

class AuthBloc{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _phoneController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _fNameController = StreamController<String>.broadcast();
  final _mlNameController = StreamController<String>.broadcast();
  final _dobController = StreamController<String>.broadcast();
  final _addressController = StreamController<String>.broadcast();

  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get fNameStream => _fNameController.stream;
  Stream<String> get mlNameStream => _mlNameController.stream;
  Stream<String> get dobStream => _dobController.stream;
  Stream<String> get addressStream => _addressController.stream;

  void dispose() {
    _passwordController.close();
    _phoneController.close();
    _fNameController.close();
    _mlNameController.close();
    _dobController.close();
    _addressController.close();
  }
  bool isValidInfo(String fname ,String mlname,
      String phone,String dob,String address, String password,) {
    if(fname==null||fname.length==0){
      _fNameController.addError('Nhập họ');
      return false;
    }
    _fNameController.sink.add('');
    if(mlname==null||mlname.length==0){
      _mlNameController.addError('Nhập họ');
      return false;
    }
    _mlNameController.sink.add('');
    if(phone==null||phone.length==0){
      _phoneController.addError('Nhập SĐT');
      return false;
    }
    _phoneController.sink.add('');

    if(dob==null||dob.length==0){
      _dobController.addError('Nhập địa chỉ');
      return false;
    }
    _dobController.sink.add('');

    if(address==null||address.length==0){
      _addressController.addError('Nhập địa chỉ');
      return false;
    }
    _addressController.sink.add('');

    if (password==null|| password.length <6) {
      _passwordController.addError('Mật khẩu phải trên 5 ký tự');
      return false;
    }
    return true;
  }
  Future<void> signIn(String phone, String password,
      Function onSuccess, Function(String) onError) async {
    try {
      // Kiểm tra đầu vào
      if (phone.isEmpty || password.isEmpty) {
        onError('Phone and password cannot be empty');
        return;
      }

      final querySnapshot = await _firestore
          .collection('Staff')
          .where('phone', isEqualTo: phone)
          .get();

      // Kiểm tra xem có người dùng nào có số điện thoại như vậy không
      if (querySnapshot.docs.isNotEmpty) {
        final user = querySnapshot.docs.first.data();
        if (user['password'] == password) {
          // Đăng nhập thành công
          onSuccess();
        } else {
          // Mật khẩu không chính xác
          onError('Password is incorrect');
        }
      } else {
        // Người dùng không tồn tại
        onError('User not found');
      }
    } catch (e) {
      // Xử lý lỗi
      onError('An error occurred. Please try again later.');
    }
  }
  Future<void> signUp(String fname ,String lname,
      String phone,String dob,String address, String password,
      Function onSuccess, Function(String) onError) async {
    try {
      // Kiểm tra đầu vào
      if (phone.isEmpty || password.isEmpty) {
        onError('Phone and password cannot be empty');
        return;
      }

      final querySnapshot = await _firestore
          .collection('Staff')
          .where('phone', isEqualTo: phone)
          .get();

      // Kiểm tra xem có người dùng nào có số điện thoại như vậy không
      if (querySnapshot.docs.isNotEmpty) {
        onError('User already exists');
      } else {
        String? lastId= await StaffFireStore().getLastDocumentId();
        String? firstChar;
        String? lastTwoChars;
        String? Id;
        if (lastId?.length == 3) {
          firstChar = lastId?.substring(0, 1); // Ký tự đầu tiên
          lastTwoChars =lastId?.substring(1); // Hai ký tự còn lại

        } else {
          print("Chuỗi phải có đúng 3 ký tự.");
        }
        int lastTwoCharsInt = int.parse(lastTwoChars!);
        if(lastTwoCharsInt+1<9){
          Id=firstChar!+"0"+(lastTwoCharsInt+1).toString();
        }
        else{
          Id=firstChar!+(lastTwoCharsInt+1).toString();
        }
        await _firestore.collection('Staff').doc(Id).set({
          'fName': fname,
          'mlName': lname,
          'phone': phone,
          'password': password,
          'address': address,
          'bDate': dob,
        });

        // Đăng ký thành công
        onSuccess();
      }
    } catch (e) {
      // Xử lý lỗi
      onError('An error occurred. Please try again later.');
    }
  }

}