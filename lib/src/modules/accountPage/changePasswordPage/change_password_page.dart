import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/bloc/auth_bloc.dart';
import 'package:qlqn/src/dialog/loading_dialog.dart';
import 'package:qlqn/src/dialog/msg_dialog.dart';
import 'package:qlqn/src/modules/accountPage/changePasswordPage/components/textfield_change_pass.dart';

import '../../../models/staff.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key,required this.staff});
  Staff staff;
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  AuthBloc authBloc = AuthBloc();

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2193645005.
  final TextEditingController _passOldController = TextEditingController();

  final TextEditingController _passNewController  = TextEditingController();

  final TextEditingController _passConfirmController  = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            fontFamily: 'Lora',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFieldChangePass(
                  content: "Mật khẩu cũ", 
                  hintText: "Nhập mật khẩu cũ",
                  controller: _passOldController,
                  streamController: authBloc.passwordStream,
                  ),
                const SizedBox(height: 20,),
                TextFieldChangePass(
                  content: "Mật khẩu mới", 
                  hintText: "Nhập mật khẩu mới",
                  controller: _passNewController,
                  streamController: authBloc.newPasswordStream,
                ),
                const SizedBox(height: 20,),
                TextFieldChangePass(
                  content: "Nhập lại mật khẩu mới", 
                  hintText: "Nhập mật lại mật khẩu mới",
                  controller: _passConfirmController,
                  streamController: authBloc.confirmPasswordStream,
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: _onSignUpClicked,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF492803),
                        fixedSize: const Size(250, 50)
                    ),
                    child: const Text(
                      'Đổi mật khẩu',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                      ),
                    )
                )
            ],
            ),
          ) ,
          )
        ),
    );
  }

  void _onSignUpClicked() async {
    var isValid =  await authBloc.isValidChangePassword(
      widget.staff.id,
      _passOldController.text,
      _passNewController.text,
      _passConfirmController.text,
    );
    if (isValid) {
      // Hiển thị loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      
      authBloc.changePassword(
          widget.staff.id,
          _passNewController.text,
            () {
          // Xử lý khi đăng ký thành công
          LoadingDialog.hideLoadingDialog(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Đổi mật khẩu thành công"),
                content: const Text("Bạn đã đổi mật khẩu thành công."),
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
          Get.back();
        },
            (msg) {
          // Xử lý khi đăng ký thất bại
          LoadingDialog.hideLoadingDialog(context);

          // Hiển thị thông báo lỗi
          MsgDialog.showMsgDialog(context, 'Change Password', msg);
        },
      );
    }
  }
}