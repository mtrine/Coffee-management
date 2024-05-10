import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/orderDetail.dart';
class CountController extends StatefulWidget {
  final OrderDetail productOrder;

  CountController({Key? key, required this.productOrder}) : super(key: key);
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
      if (widget.productOrder.quantity > 0) {
        widget.productOrder.quantity--;
        itemCount.value = widget.productOrder.quantity; // Cập nhật giá trị itemCount
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 137,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: _decrementCounter,
            child: Text('-',style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(10, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero, // Remove padding
            ),
          ),
          Obx(() => Text(
            '${itemCount.value}', // Sử dụng itemCount thay cho widget.productOrder.quantity
            style: TextStyle(fontSize: 15),
          )),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('+', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero, // Remove padding
            ),
          ),
        ],
      ),
    );
  }
}