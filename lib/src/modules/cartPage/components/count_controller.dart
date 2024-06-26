import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/orderDetail.dart';
class CountController extends StatefulWidget {
  final OrderDetail productOrder;
  Function handleDelete;
  CountController({super.key, required this.productOrder,required this.handleDelete});
  @override
  _CountControllerState createState() => _CountControllerState();
}

class _CountControllerState extends State<CountController> {
  late RxInt itemCount; // Sử dụng RxInt thay cho Obs để theo dõi thay đổi số lượng

  @override
  void initState() {
    super.initState();
    itemCount = widget.productOrder.quantity.obs; // Khởi tạo itemCount ở initState
  }

  void _incrementCounter() {

      widget.productOrder.quantity++;
      itemCount.value = widget.productOrder.quantity; // Cập nhật giá trị itemCount

  }

  void _decrementCounter() {
      if (widget.productOrder.quantity >1 ) {
        widget.productOrder.quantity--;
        itemCount.value = widget.productOrder.quantity; // Cập nhật giá trị itemCount
      }
      else{
        widget.handleDelete(widget.productOrder.productId);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: _decrementCounter,
            style: TextButton.styleFrom(
              fixedSize: const Size(10, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero, // Remove padding
            ),
            child: const Text('-',style: TextStyle(fontSize: 20)),
          ),
          Obx(() => Expanded(
            child: Text(
              '${itemCount.value}', // Sử dụng itemCount thay cho widget.productOrder.quantity
              style: const TextStyle(fontSize: 15),
            ),
          )),
          TextButton(
            onPressed: _incrementCounter,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero, // Remove padding
            ),
            child: const Text('+', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}