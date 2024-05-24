
import 'package:flutter/material.dart';

import '../../../firebase/staff_firestore.dart';
import '../../../models/staff.dart';
import 'components/cardInformationStaff.dart';

class WatchListStaffPage extends StatefulWidget {
  const WatchListStaffPage({super.key});

  @override
  State<WatchListStaffPage> createState() => _WatchListStaffPageState();
}

class _WatchListStaffPageState extends State<WatchListStaffPage> {
  List<Staff> listStaff=[];
  bool deleteMode = false;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  void _fetchData() async {
    StaffFireStore staffFireStore = StaffFireStore();
    List<Staff> listStaff=await staffFireStore.getAll();
    setState(() {
      this.listStaff = listStaff;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Danh sách nhân viên',
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
            onPressed: (){
              setState(() {
                deleteMode = !deleteMode;
              });
            },
          ),
        ],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body:SafeArea(
        child:ListView(
          children: listStaff.map((staff) => CardInformationStaff(staff: staff,deleteMode: deleteMode,)).toList(),
        )
      )
    );
  }
}
