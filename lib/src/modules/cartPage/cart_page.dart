import 'package:flutter/material.dart';
import 'package:qlqn/src/modules/cartPage/components/card_order_item.dart';
import '../../models/staff.dart';
import '../../models/product.dart';
import 'components/note_total_checkout.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key,required this.staff,required this.listOrderItem}) : super(key: key);
  List<Product> listOrderItem ;
  Staff staff;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Xác nhận đơn hàng',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            fontFamily: 'Lora',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: listOrderItem.map((e) => CardItemOder(product: e)).toList(),
              ),
            ),
            NoteTotalCheckOut(),
          ],
        ),
      ),
    );
  }
}






