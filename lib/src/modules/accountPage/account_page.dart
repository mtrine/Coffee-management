import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/accountPage/components/ButtonAccountPage.dart';
import 'package:qlqn/src/modules/accountPage/informationDetail/information_detail.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key,required this.staff});
  final Staff staff;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Tài khoản nhân viên',
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
        child:Column(
          children: [
            ButtonAccountPage( text: "Thông tin cá nhân", onTap: ()=>Get.to(InformationDetailPage(staff: staff))),
            ButtonAccountPage( text: "Tài khoản", onTap: (){})
        ],
        ) ,
        ),
    );
  }
}