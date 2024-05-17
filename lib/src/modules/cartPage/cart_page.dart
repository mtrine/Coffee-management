import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/orderDetail.dart';
import 'package:qlqn/src/modules/cartPage/components/card_order_item.dart';
import '../../models/staff.dart';
import 'components/note_total_checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.staff, required this.listOrderItem});

  final List<OrderDetail> listOrderItem;
  final Staff staff;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var total;
  bool isCheckOut = false;
  @override
  void initState() {
    super.initState();
    total = 0.obs;
    calculateTotal();
  }

  Future<int> calculateTotal() async {
    dynamic newtotal = 0;
    for (var productOrder in widget.listOrderItem) {
      DocumentSnapshot snapshot = await productOrder.productId!.get();
      newtotal += snapshot['unitPrice'] * productOrder.quantity;
    }
    return total.value = newtotal;
  }

  Future<void> _fetchData() async {
    print('Thanh toán nè');
    setState(() {
      widget.listOrderItem.clear();
      total.value = 0;
    });
  }

  void _handleDelete(DocumentReference productId) {
    setState(() {
      widget.listOrderItem.removeWhere((item) => item.productId == productId);
    });
  }
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
                child: widget.listOrderItem.isEmpty
                    ? const Center(
                  child: Text(
                    'Giỏ hàng của bạn đang trống',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                )
                    : ListView(
                  shrinkWrap: true,
                  children: widget.listOrderItem
                      .map((e) => CardItemOder(handleDelete: _handleDelete,productOrder: e, total: total))
                      .toList(),
                ),
              ),
              TextButton(
                  onPressed: (){
                    widget.listOrderItem.clear();
                    setState(() {
                      total.value = 0;
                    });
                  },
                  child: const Text(
                    'Clear all',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Secondary Family'
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: ElevatedButton(
                    onPressed:() async{
                      var newTotal= await calculateTotal();
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        isScrollControlled: true,
                        builder:(BuildContext context) {
                          return  NoteTotalCheckOut(
                            total: newTotal,
                            staff: widget.staff,
                            listOrderItem: widget.listOrderItem,
                            onCheckOut: () {
                              _fetchData();
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF492803),
                      fixedSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                            color:Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Secondary Family'
                        )
                    )
                ),
              )
            ],
          ),

      ),
    );
  }
}

