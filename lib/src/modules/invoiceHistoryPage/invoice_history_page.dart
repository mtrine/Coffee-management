import 'package:flutter/material.dart';
import 'package:qlqn/src/firebase/order_firestore.dart';
import '../../models/order.dart';
import 'components/order_card.dart';
class InvoiceHistoryPage extends StatefulWidget {
  const InvoiceHistoryPage({super.key});

  @override
  State<InvoiceHistoryPage> createState() => _InvoiceHistoryPageState();
}

class _InvoiceHistoryPageState extends State<InvoiceHistoryPage> {
  List<Orders> orederList = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async{
    OrderFireStore orderFireStore = OrderFireStore();
    List<Orders> orderList = await orderFireStore.getAllDocument();
    setState(() {
      orederList = orderList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Lịch sử hóa đơn',
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
      body: SafeArea(
        child:ListView(
          children: orederList.map((e) => OrderCard(orders: e)).toList(),
        )
      ),
    );
  }
}

