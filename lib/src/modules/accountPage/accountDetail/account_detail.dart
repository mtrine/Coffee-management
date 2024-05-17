import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/accountPage/changePasswordPage/change_password_page.dart';
import 'package:qlqn/src/modules/logInAndSignUpPage/logInPage/login_page.dart';

import '../components/ButtonAccountPage.dart';

class AccountDetailPage extends StatelessWidget {
   AccountDetailPage({super.key,required this.staff});
  Staff staff;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Tài khoản',
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
        child: Column(
          children: [
             ButtonAccountPage( text: "Đổi mật khẩu", onTap: ()=>Get.to(ChangePasswordPage(staff: staff,))),
             ButtonAccountPage( text: "Đăng xuất", onTap: ()=>Get.to(LogInPage())),
        ],
        )
      ),
    );
  }
}