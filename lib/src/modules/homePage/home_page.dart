import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/invoiceHistoryPage/invoice_history_page.dart';
import '../../models/orderDetail.dart';
import '../optionOrderPage/option_order_page.dart';
import 'components/card_option.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key,required this.staff, required this.listProtuctOrder});
  Staff staff;
  List<OrderDetail> listProtuctOrder ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text('Welcome.',
          style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontFamily: 'Lora',),
        ),
          automaticallyImplyLeading: false
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child:GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(
              ),
              children:[
                CardOption(icon: Icons.edit_note,onTap: ()=>Get.to(OptionOrderPage(staff: staff,listProtuctOrder: listProtuctOrder,)),content: "ORDERS",),
                CardOption(icon: Icons.ballot,onTap: ()=> Get.to(const InvoiceHistoryPage()),content: "INVOICE",),
                CardOption(icon: Icons.assignment_ind,onTap: ()=> Get.to(const InvoiceHistoryPage()),content: "TÀI KHOẢN",),
              ]
          )

        )
      ) ,
    );
  }
}


