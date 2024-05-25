import 'package:flutter/material.dart';
import '../../../bloc/auth_bloc.dart';
import '../../../dialog/loading_dialog.dart';
import '../../../dialog/msg_dialog.dart';
import 'components/textfield_to_addStaff.dart';

class AddStaffPage extends StatefulWidget {
  const AddStaffPage({super.key});

  @override
  State<AddStaffPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<AddStaffPage> {
  AuthBloc authBloc = AuthBloc();

  final TextEditingController _fNameController = TextEditingController();

  final TextEditingController _mlNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF492803),
          title: const Text(
            'Thêm nhân viên',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              fontFamily: 'Lora',
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
        ),
        body: SafeArea(
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFieldToAddStaff (
                      content: 'Họ',
                      hintText: 'Nhập họ',
                      controller: _fNameController,
                      isPassword: false,
                      streamController: authBloc.fNameStream
                  ),
                  const SizedBox(height: 10),
                  TextFieldToAddStaff(content: 'Tên',hintText: 'Nhập tên',controller: _mlNameController,isPassword: false,streamController: authBloc.mlNameStream),
                  const SizedBox(height: 10),
                  TextFieldToAddStaff(content: 'SDT',hintText: 'Nhập số điện thoại',controller: _phoneController,isPassword: false,streamController: authBloc.phoneStream),
                  const SizedBox(height: 10),
                  TextFieldToAddStaff(content: 'Ngày sinh',hintText: 'XX/YY/ZZZZ',controller: _dobController,isPassword: false,streamController: authBloc.dobStream),
                  const SizedBox(height: 10),
                  TextFieldToAddStaff(content: 'Địa chỉ',hintText: 'Nhập địa chỉ',controller: _addressController,isPassword: false,streamController: authBloc.addressStream),
                  const SizedBox(height: 10),
                  TextFieldToAddStaff(content: 'Mật khẩu',hintText: 'Nhập mật khẩu',controller: _passwordController,isPassword: true,streamController: authBloc.passwordStream),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: _onSignUpClicked,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF492803),
                          fixedSize: const Size(250, 50)
                      ),
                      child: const Text(
                        'Thêm nhân viên',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20
                        ),
                      )
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
  void _onSignUpClicked() async {
    var isValid = authBloc.isValidInfo(
      _fNameController.text,
      _mlNameController.text,
      _phoneController.text,
      _dobController.text,
      _addressController.text,
      _passwordController.text,
    );
    if (isValid) {
      // Hiển thị loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      // Gọi phương thức sign up từ authBloc
      authBloc.signUp(
        _fNameController.text,
        _mlNameController.text,
        _phoneController.text,
        _dobController.text,
        _addressController.text,
        _passwordController.text,
            () {
          // Xử lý khi đăng ký thành công
          LoadingDialog.hideLoadingDialog(context);

          // Hiển thị thông báo đăng ký thành công
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Thêm nhân viên"),
                content: const Text("Bạn đã thêm nhân viên thành công!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Đóng"),
                  ),
                ],
              );
            },
          );
        },
            (msg) {
          // Xử lý khi đăng ký thất bại
          LoadingDialog.hideLoadingDialog(context);

          // Hiển thị thông báo lỗi
          MsgDialog.showMsgDialog(context, 'Sign Up', msg);
        },
      );
    }
  }


}




