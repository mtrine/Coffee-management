import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/models/staff.dart';

import '../../../../firebase/staff_firestore.dart';

class CardInformationStaff extends StatefulWidget {
  CardInformationStaff({
    super.key,
    required this.staff,
    required this.deleteMode,
  });

  final Staff staff;
  final bool deleteMode;

  @override
  State<CardInformationStaff> createState() => _OrderCardState();
}

class _OrderCardState extends State<CardInformationStaff> {
  void deleteStaff() {
    StaffFireStore staffFireStore = StaffFireStore();
    staffFireStore.delete(widget.staff.id);
  }

  void confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa nhân viên'),
          content: Text('Bạn có muốn xóa nhân viên ${widget.staff.fname} ${widget.staff.mlname}?'),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Đồng ý'),
              onPressed: () {
                deleteStaff();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF492803), width: 2),
            bottom: BorderSide(color: Color(0xFF492803), width: 2),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.staff.id,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Secondary Family',
                ),
              ),
            ),
            const SizedBox(
              height: 100,
              child: DottedLine(
                direction: Axis.vertical,
                lineLength: double.infinity,
                lineThickness: 1.2,
                dashLength: 4.0,
                dashColor: Color(0xFF492803),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.staff.fname} ${widget.staff.mlname}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                    Text(
                      widget.staff.phone,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                    Text(
                      widget.staff.manager ? 'Quản lý' : 'Nhân viên',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.deleteMode,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 40),
                onPressed: confirmDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
