import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/accountPage/account_page.dart';
import 'package:qlqn/src/modules/invoiceHistoryPage/invoice_history_page.dart';
import 'package:qlqn/src/modules/manageStaffPage/manageStaffPage.dart';
import '../../models/orderDetail.dart';
import '../optionOrderPage/option_order_page.dart';
import 'components/card_option.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key,required this.staff, required this.listProtuctOrder});
  Staff staff;
  List<OrderDetail> listProtuctOrder ;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onTapManage(){
    if(widget.staff.manager){
      Get.to(() => ManageStaffPage());
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Lỗi"),
            content: const Text("Bạn không có quyền truy cập."),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( // Sử dụng WillPopScope để kiểm soát việc quay lại từ nút "Back" trên điện thoại
      onWillPop: () async {
        // Thực hiện chuyển hướng tới trang khác thay vì quay lại trang trước đó
        Get.offAll(() => HomePage(staff: widget.staff, listProtuctOrder: widget.listProtuctOrder));
        return false; // Trả về false để ngăn việc quay lại trang trước đó
      },
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: const Color(0xFF492803),
          title: Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Welcome, ${widget.staff.fname} ${widget.staff.mlname}!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                fontFamily: 'Lora',
              ),
              softWrap: true, // Cho phép xuống hàng
              overflow: TextOverflow.visible, // Cho phép phần văn bản hiển thị đầy đủ và xuống hàng nếu cần
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                        crossAxisSpacing: 5, // Khoảng cách giữa các phần tử theo trục ngang
                        mainAxisSpacing:5
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:[
                      CardOption(icon: Icons.edit_note,onTap: ()=>Get.to(OptionOrderPage(staff: widget.staff,listProtuctOrder: widget.listProtuctOrder,)),content: "ORDERS",),
                      CardOption(icon: Icons.ballot,onTap: ()=> Get.to(const InvoiceHistoryPage()),content: "INVOICE",),
                      CardOption(icon: Icons.assignment_ind,onTap: ()=> Get.to(AccountPage(staff: widget.staff,)),content: "ACCOUNT",),
                      CardOption(icon: Icons.manage_accounts,onTap:onTapManage,content: "MANAGE",),
                    ]
                )
            )
        ),
      ),
    );
  }
}
