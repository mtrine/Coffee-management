import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/staff.dart';
import '../optionOrderPage/option_order_page.dart';
import 'components/card_option.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key,required this.staff});
  Staff staff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF492803),
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
                CardOption(icon: Icons.edit_note,onTap: ()=>Get.to(OptionOrderPage(staff: staff,)),content: "ORDERS",),
                CardOption(icon: Icons.ballot,onTap: ()=> print(staff.id),content: "INVOICE",),
              ]
          )

        )
      ) ,
    );
  }
}


