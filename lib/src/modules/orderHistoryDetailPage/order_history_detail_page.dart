import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qlqn/src/models/order.dart';
import '../../firebase/orderDetail_firestore.dart';
import '../../models/orderDetail.dart';
import '../../models/product.dart';
import '../../models/staff.dart';
class OrderHistoryDetailPage extends StatefulWidget {
  OrderHistoryDetailPage({super.key, required this.orders,required this.staffId, required this.staffName});
  final Orders orders;
  final String staffId;
  final String staffName;
  @override
  State<OrderHistoryDetailPage> createState() => _OrderHistoryDetailPageState();
}

class _OrderHistoryDetailPageState extends State<OrderHistoryDetailPage> {
  List<OrderDetail> orderDetails = [];
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    DocumentReference orderId = FirebaseFirestore.instance.collection('Orders').doc(widget.orders.id);
    List<OrderDetail> fetchedOrderDetails = await OrderDetailFireStore().getListOrderDetailByOrderId(orderId);
    List<Product> fetchedProducts = await OrderDetailFireStore().getProductById( fetchedOrderDetails);
    setState(() {
      orderDetails = fetchedOrderDetails;
      products = fetchedProducts;
    });
  }

  List<DataRow> getDataRows() {
    List<DataRow> rows = [];
    for (int i = 0; i < orderDetails.length; i++) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(
              orderDetails[i].quantity.toString(),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )),
            DataCell(Text(
              products[i].name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )),
            DataCell(Text(
              '${orderDetails[i].quantity * products[i].unitPrice}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )),
          ],
        ),
      );
    }
    return rows;
  }
  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('HH:mm dd/MM/yyyy').format(date);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Chi tiết hóa đơn',
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        return const Color(0xFF492803); // Màu nền cho hàng tiêu đề
                      },
                    ),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Số lượng',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Màu chữ trắng để nổi bật trên nền đen
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tên món',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Thành tiền',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    rows: getDataRows(),
                  ),
                ),
              ),
              TextRow(title:"Thời gian order", content: formatTimestamp(widget.orders.orderDate)),
              TextRow(title:"Nhân viên", content:"${widget.staffName}-${widget.staffId}"),
              TextRow(title:"Tổng tiền", content: widget.orders.total.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class TextRow extends StatelessWidget {
  TextRow({
    super.key,
    required this.title,
    required this.content,
  });
  String title;
  String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20,10, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text(
              title,
              style: const TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto'
              ),
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Secondary Family',
              ),
            ),
          ]
      ),
    );
  }
}
