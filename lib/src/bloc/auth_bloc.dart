import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlqn/src/firebase/staff_firestore.dart';

class AuthBloc {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _phoneController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _fNameController = StreamController<String>.broadcast();
  final _mlNameController = StreamController<String>.broadcast();
  final _addressController = StreamController<String>.broadcast();
  final _newPasswordController = StreamController<String>.broadcast();
  final _confirmPasswordController = StreamController<String>.broadcast();
  final _oldPasswordController = StreamController<String>.broadcast();

  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get fNameStream => _fNameController.stream;
  Stream<String> get mlNameStream => _mlNameController.stream;
  Stream<String> get addressStream => _addressController.stream;
  Stream<String> get newPasswordStream => _newPasswordController.stream;
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream;
  Stream<String> get oldPasswordStream => _oldPasswordController.stream;

  void dispose() {
    _phoneController.close();
    _passwordController.close();
    _fNameController.close();
    _mlNameController.close();
    _addressController.close();
    _newPasswordController.close();
    _confirmPasswordController.close();
    _oldPasswordController.close();
  }

  bool isValidInfo(String fname, String mlname, String phone, String address, String password) {
    if (fname.isEmpty) {
      _fNameController.addError('Nhập họ');
      return false;
    }
    _fNameController.sink.add('');

    if (mlname.isEmpty) {
      _mlNameController.addError('Nhập họ');
      return false;
    }
    _mlNameController.sink.add('');

    if (phone.isEmpty) {
      _phoneController.addError('Nhập SĐT');
      return false;
    }
    _phoneController.sink.add('');


    if (address.isEmpty) {
      _addressController.addError('Nhập địa chỉ');
      return false;
    }
    _addressController.sink.add('');

    if (password.length < 6) {
      _passwordController.addError('Mật khẩu phải trên 5 ký tự');
      return false;
    }

    return true;
  }

  Future<void> signIn(String phone, String password, Function onSuccess, Function(String) onError) async {
    try {
      if (phone.isEmpty || password.isEmpty) {
        onError('Phone and password cannot be empty');
        return;
      }

      final querySnapshot = await _firestore.collection('Staff').where('phone', isEqualTo: phone).get();

      if (querySnapshot.docs.isNotEmpty) {
        final user = querySnapshot.docs.first.data();
        if (user['password'] == password) {
          onSuccess();
        } else {
          onError('Password is incorrect');
        }
      } else {
        onError('User not found');
      }
    } catch (e) {
      onError('An error occurred. Please try again later.');
    }
  }

  Future<void> signUp(String fname, String lname, String phone, String address, String password, Function onSuccess, Function(String) onError) async {
    try {
      if (phone.isEmpty || password.isEmpty) {
        onError('Phone and password cannot be empty');
        return;
      }

      final querySnapshot = await _firestore.collection('Staff').where('phone', isEqualTo: phone).get();

      if (querySnapshot.docs.isNotEmpty) {
        onError('User already exists');
      } else {
        String? lastId = await StaffFireStore().getLastDocumentId();
        String? firstChar;
        String? lastTwoChars;
        String? id;

        if (lastId!.length == 3) {
          firstChar = lastId.substring(0, 1);
          lastTwoChars = lastId.substring(1);
        } else {
          print("Chuỗi phải có đúng 3 ký tự.");
        }

        int lastTwoCharsInt = int.parse(lastTwoChars!);
        if (lastTwoCharsInt + 1 < 9) {
          id = "${firstChar!}0${lastTwoCharsInt + 1}";
        } else {
          id = firstChar! + (lastTwoCharsInt + 1).toString();
        }

        await _firestore.collection('Staff').doc(id).set({
          'fName': fname,
          'mlName': lname,
          'phone': phone,
          'password': password,
          'address': address,
          'manager': false,
        });

        onSuccess();
      }
    } catch (e) {
      onError('An error occurred. Please try again later.');
    }
  }

  Future<bool> isValidChangePassword(String staffId, String oldPassword, String newPassword, String confirmPassword) async {
    final docSnapshot = await _firestore.collection('Staff').doc(staffId).get();
    final user = docSnapshot.data();
    if (user == null) {
      return false;
    }
    if (user['password'] != oldPassword) {
      _oldPasswordController.addError('Mật khẩu cũ không đúng');
      return false;
    }
    _oldPasswordController.sink.add('');
    if (oldPassword=='') {
      _oldPasswordController.addError('Nhập mật khẩu cũ');
      return false;
    }
    _oldPasswordController.sink.add('');

    if (newPassword.isEmpty||newPassword.length < 6) {
      _newPasswordController.addError('Mật khẩu phải hơn 6 ký tự');
      return false;
    }
    _newPasswordController.sink.add('');

    if (newPassword == user['password']) {
      _newPasswordController.addError('Mật khẩu mới phải khác với mật khẩu cũ');
      return false;
    }
    _newPasswordController.sink.add('');
    if (confirmPassword.isEmpty || confirmPassword != newPassword) {
      _confirmPasswordController.addError('Mật khẩu không khớp');
      return false;
    }
    _confirmPasswordController.sink.add('');

    return true;
  }

  Future<void> changePassword(String staffId, String newPassword, Function onSuccess, Function(String) onError) async {
    try {
      await _firestore.collection('Staff').doc(staffId).update({
        'password': newPassword
      });
      onSuccess();
    } catch (e) {
      onError('An error occurred while updating the password. Please try again later.');
    }
  }
}
