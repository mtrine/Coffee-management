import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../bloc/auth_bloc.dart';
import '../../../dialog/loading_dialog.dart';
import '../../../dialog/msg_dialog.dart';
import '../../homePage/home_page.dart';
import 'components/textfield_to_signup.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthBloc authBloc = AuthBloc();

  TextEditingController _fNameController = TextEditingController();

  TextEditingController _mlNameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _dobController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

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
                SizedBox(height: 10),
                TextFieldToSignUp(content: 'Tên',hintText: 'Nhập tên',controller: _mlNameController,isPassword: false,streamController: authBloc.mlNameStream),
                SizedBox(height: 10),
                TextFieldToSignUp(content: 'SDT',hintText: 'Nhập số điện thoại',controller: _phoneController,isPassword: false,streamController: authBloc.phoneStream),
                SizedBox(height: 10),
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
  _onSignUpClicked(){
    var isValid=authBloc.isValidInfo(
        _fNameController.text,
        _mlNameController.text,
        _phoneController.text
        , _dobController.text,
        _addressController.text,
        _passwordController.text);
    if(isValid){
      //create user
      //loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(
          _fNameController.text,
          _mlNameController.text,
          _phoneController.text
          , _dobController.text,
          _addressController.text,
          _passwordController.text
          , (){
        LoadingDialog.hideLoadingDialog(context);
        Get.to(const HomePage());
      },(msg){
        // show msg dialog
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Sign Up', msg);
      });
    }
  }
}


