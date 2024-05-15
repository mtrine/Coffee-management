import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/firebase/staff_firestore.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/accountPage/editInformationPage/components/textField_edit.dart';

class EditInformationPage extends StatefulWidget {
  final Staff staff;

  EditInformationPage({Key? key, required this.staff}) : super(key: key);

  @override
  State<EditInformationPage> createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  late final TextEditingController _fNameController;
  late final TextEditingController _mlNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _dobController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _fNameController = TextEditingController(text: widget.staff.fname);
    _mlNameController = TextEditingController(text: widget.staff.mlname);
    _phoneController = TextEditingController(text: widget.staff.phone);
    _dobController = TextEditingController(text: widget.staff.dob);
    _addressController = TextEditingController(text: widget.staff.address);
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _mlNameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void updateInformation() {
    StaffFireStore staffFireStore = StaffFireStore();
    Staff staff = Staff(
      widget.staff.id,
      _fNameController.text,
      _mlNameController.text,
      "",
      _phoneController.text,
      _addressController.text,
      _dobController.text,
    );
    staffFireStore.update(staff);
    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Chỉnh sửa thông tin cá nhân',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'Lora',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFieldEdit(
                  content: "Họ",
                  hintText: "Nhập họ",
                  controller: _fNameController,
                ),
                const SizedBox(height: 20),
                TextFieldEdit(
                  content: "Tên",
                  hintText: "Nhập tên",
                  controller: _mlNameController,
                ),
                const SizedBox(height: 20),
                TextFieldEdit(
                  content: "Số điện thoại",
                  hintText: "Nhập SĐT",
                  controller: _phoneController,
                ),
                const SizedBox(height: 20),
                TextFieldEdit(
                  content: "Ngày/Tháng/Năm",
                  hintText: "Nhập ngày tháng năm sinh",
                  controller: _dobController,
                ),
                const SizedBox(height: 20),
                TextFieldEdit(
                  content: "Địa chỉ",
                  hintText: "Nhập địa chỉ",
                  controller: _addressController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: updateInformation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff492803),
                    fixedSize: const Size(300, 40),
                  ),
                  child: const Text(
                    'Hoàn tất chỉnh sửa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Secondary Family',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
