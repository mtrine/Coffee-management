import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../firebase/order_firestore.dart';
import '../../../models/order.dart';
import '../../orderHistoryDetailPage/order_history_detail_page.dart';
class OrderCard extends StatefulWidget {
  OrderCard({
    super.key,
    required this.orders,
  });
  Orders orders;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String staffName = '';
  String staffId = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
    print(widget.orders.staffId);
  }

  void _fetchData() async {
    OrderFireStore orderFireStore = OrderFireStore();
    String? name = await orderFireStore.getNameStaff(widget.orders.staffId);
    String id = widget.orders.staffId.id;
    setState(() {
      staffName = name!;
      staffId = id;
    });
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('HH:mm dd/MM/yyyy').format(date);
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thời gian',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                    Text(
                      formatTimestamp(widget.orders.orderDate),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                    const Text(
                      'Nhân viên order',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                    Text(
                      staffName!=""?'$staffName-$staffId':"Nhân viên đã bị xóa",
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
            const SizedBox(
              height: 150,
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tổng tiền',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.orders.total.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Secondary Family',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(OrderHistoryDetailPage(orders: widget.orders, staffName: staffName, staffId: staffId));
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        backgroundColor: const Color(0xFF492803),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                          Text(
                            'Xem chi tiết',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Secondary Family',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}