import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/cartPage/cart_page.dart';
import 'package:qlqn/src/modules/editMenuPage/edit_menu_page.dart';
import 'package:qlqn/src/modules/orderDetail/order_detail_page.dart';
import '../../models/category.dart';
import '../../models/orderDetail.dart';
import 'components/card_category.dart';
import 'package:get/get.dart';

class OptionOrderPage extends StatefulWidget {
  OptionOrderPage({Key? key, required this.staff,required this.listProtuctOrder}) : super(key: key);
  Staff staff;
  List<OrderDetail> listProtuctOrder ;
  @override
  _OptionOrderPageState createState() => _OptionOrderPageState();
}

class _OptionOrderPageState extends State<OptionOrderPage> {
  late final Stream<QuerySnapshot> _stream =
  FirebaseFirestore.instance.collection('Category').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6e0c7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            fontFamily: 'Lora',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
            onPressed: () {
              Get.to(CartPage(listOrderItem: widget.listProtuctOrder,staff: widget.staff));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200, // Độ cao của ListView
              child: StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Categories categories = Categories(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['image_url'],
                      );
                      return GestureDetector(
                          onTap: (){
                            Get.to(OrderDeatilPage(categories: categories,listProtuctOrder: widget.listProtuctOrder , ));
                          },
                          child: CardCategory(category: categories));
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 5), // Khoảng cách giữa ListView và nút
            ElevatedButton(
              onPressed: (){
                Get.to(EditMenuPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF492803),
                fixedSize: Size(250, 50),
              ),
              child: Text(
                'Chỉnh sửa menu',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width:double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFF492803), width: 2),
              ),
              child: Text('Best Seller', style: TextStyle(color: Color(0xFF492803), fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Second Family')),
            )
          ],
        ),
      ),
    );
  }
}
