import 'package:flutter/material.dart';
import 'package:qlqn/src/modules/manageStaffPage/components/buttonManagePage.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/modules/manageStaffPage/watchListStaffPage/watchListStaffPage.dart';

import 'addStaffPage/addStaffPage.dart';
class ManageStaffPage extends StatelessWidget {
  const ManageStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Quản lí nhân viên',
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
      body: Column(
        children:[
          ButtonManagePage(
              icon:Icons.add_box,
              text:'Thêm nhân viên',
             onTap: ()=>Get.to(const AddStaffPage())
          ),
          ButtonManagePage(
              icon:Icons.remove_red_eye,
              text:'Danh sách nhân viên',
              onTap: ()=>Get.to(const WatchListStaffPage())
          )
        ]
      ),
    );
  }
}
