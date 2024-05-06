import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../optionOrderPage/option_order_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                CardOption(icon: Icons.edit_note,onTap: ()=>Get.to(OptionOrderPage()),content: "ORDERS",),
                CardOption(icon: Icons.ballot,onTap: ()=>Get.to(OptionOrderPage()),content: "INVOICE",),
              ]
          )

        )
      ) ,
    );
  }
}

class CardOption extends StatelessWidget {
  CardOption({
    super.key,
    required this.icon,
    required this.onTap,
    required this.content,
  });
  IconData icon;
  final VoidCallback onTap;
  String content;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap:onTap ,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        margin: const EdgeInsets.all(8), // Đặt margin cho Card
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF492803), width: 2),
          borderRadius: BorderRadius.circular(12),
        ), // Đặt padding cho nội dung bên trong Card
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xffc49a6c),
              borderRadius: BorderRadius.circular(12), // Đặt bán kính cong cho góc của Container
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 70, color: Colors.white),
                Text(
                  content,
                  style: const TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500,fontFamily: "Second Family"),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
