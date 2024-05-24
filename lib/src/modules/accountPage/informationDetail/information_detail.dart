import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/firebase/staff_firestore.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/accountPage/editInformationPage/edit_information_page.dart';
import 'package:qlqn/src/modules/accountPage/informationDetail/components/row_information.dart';

class InformationDetailPage extends StatefulWidget {
  final Staff staff;

  InformationDetailPage({Key? key, required this.staff}) : super(key: key);

  @override
  State<InformationDetailPage> createState() => _InformationDetailPageState();
}

class _InformationDetailPageState extends State<InformationDetailPage> {
  late Staff staffInfor;
  late String role;
  @override
  void initState() {
    super.initState();
    staffInfor = widget.staff;
    getStaffInformation();
  }

  void getStaffInformation() async {
    StaffFireStore staffFireStore = StaffFireStore();
    Staff staff = await staffFireStore.getById(widget.staff.id);
    role= staff.manager? 'Quản lý' : 'Nhân viên';
    setState(() {
      staffInfor = staff;
    });
  }

  Future<void> _navigateToEditPage() async {
    final result = await Get.to(() => EditInformationPage(staff: staffInfor));
    if (result == true) {
      getStaffInformation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            fontFamily: 'Lora',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.mode_edit, color: Colors.white, size: 30),
            onPressed: _navigateToEditPage,
          ),
        ],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              RowInformation(
                title: "Họ tên:",
                content: '${staffInfor.fname} ${staffInfor.mlname}',
              ),
              RowInformation(
                title: "Số điện thoại:",
                content: staffInfor.phone,
              ),
              RowInformation(
                title: "Ngày sinh:",
                content: staffInfor.dob,
              ),
              RowInformation(
                title: "Địa chỉ:",
                content: staffInfor.address,
              ),
              RowInformation(
                title: "Chức vụ:",
                content: role,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


