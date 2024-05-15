import 'package:flutter/material.dart';
import '../../../bloc/auth_bloc.dart';
import '../../../dialog/loading_dialog.dart';
import '../../../dialog/msg_dialog.dart';
import 'components/textfield_to_signup.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    return SafeArea(
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFieldToSignUp (content: 'Họ',hintText: 'Nhập họ',controller: _fNameController,isPassword: false,streamController: authBloc.fNameStream),
                const SizedBox(height: 10),
                TextFieldToSignUp(content: 'Tên',hintText: 'Nhập tên',controller: _mlNameController,isPassword: false,streamController: authBloc.mlNameStream),
                const SizedBox(height: 10),
                TextFieldToSignUp(content: 'SDT',hintText: 'Nhập số điện thoại',controller: _phoneController,isPassword: false,streamController: authBloc.phoneStream),
                const SizedBox(height: 10),
                TextFieldToSignUp(content: 'Ngày sinh',hintText: 'XX/YY/ZZZZ',controller: _dobController,isPassword: false,streamController: authBloc.dobStream),
                const SizedBox(height: 10),
                TextFieldToSignUp(content: 'Địa chỉ',hintText: 'Nhập địa chỉ',controller: _addressController,isPassword: false,streamController: authBloc.addressStream),
                const SizedBox(height: 10),
                TextFieldToSignUp(content: 'Mật khẩu',hintText: 'Nhập mật khẩu',controller: _passwordController,isPassword: true,streamController: authBloc.passwordStream),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _onSignUpClicked,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF492803),
                        fixedSize: const Size(250, 50)
                    ),
                    child: const Text(
                      'Đăng ký',
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
                title: const Text("Đăng ký thành công"),
                content: const Text("Chúc mừng! Bạn đã đăng ký thành công."),
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




