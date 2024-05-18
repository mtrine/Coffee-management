import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/models/staff.dart';
import 'package:qlqn/src/modules/cartPage/cart_page.dart';
import 'package:qlqn/src/modules/editMenuPage/edit_menu_page.dart';
import 'package:qlqn/src/modules/orderDetail/order_detail_page.dart';
import '../../firebase/orderDetail_firestore.dart';
import '../../models/category.dart';
import '../../models/orderDetail.dart';
import '../../models/product.dart';
import 'components/card_product_bestseller.dart';
import 'components/card_category.dart';
import 'package:get/get.dart';

class OptionOrderPage extends StatefulWidget {
  OptionOrderPage({super.key, required this.staff, required this.listProtuctOrder});
  final Staff staff;
  final List<OrderDetail> listProtuctOrder;

  @override
  _OptionOrderPageState createState() => _OptionOrderPageState();
}

class _OptionOrderPageState extends State<OptionOrderPage> {
  late final Stream<QuerySnapshot> _stream =
  FirebaseFirestore.instance.collection('Category').snapshots();
  List<Product> listProduct = [];
  @override
  void initState() {
    super.initState();
    fecthData();
  }
  void fecthData() async {
    List<Product> listProduct = await OrderDetailFireStore().getProductBestSeller();
    setState(() {
      this.listProduct = listProduct;
    });
  }

  void addProductToOrder(Product product){
    try {
      // Create a DocumentReference for the product
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('Product').doc(product.id);
      // Check if the product is already in the list
      bool productExists = false;
      for (OrderDetail orderDetail in widget.listProtuctOrder) {
        if (orderDetail.productId == documentReference) {
          // If the product exists, increment the quantity
          orderDetail.quantity += 1;
          productExists = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Đã thêm 1 ${product.name} vào giỏ hàng'),
              duration: const Duration(seconds: 1),
            ),
          );
          break;
        }
      }

      // If the product is not in the list, add it
      if (!productExists) {
        OrderDetail orderDetail = OrderDetail(
          "", null, documentReference, 1,
        );
        widget.listProtuctOrder.add(orderDetail);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('${product.name} đã thêm vào giỏ hàng'),
              duration: const Duration(seconds: 1),
          ),

        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6e0c7),
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
              Get.to(CartPage(listOrderItem: widget.listProtuctOrder, staff: widget.staff));
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
              child: StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      Categories categories = Categories(
                        doc.id,
                        doc['name'],
                        doc['image_url'],
                      );
                      return GestureDetector(
                        onTap: () {
                          Get.to(OrderDeatilPage(
                              categories: categories,
                              listProtuctOrder: widget.listProtuctOrder
                          )
                          );
                        },
                        child: CardCategory(category: categories),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 5), // Khoảng cách giữa ListView và nút
            ElevatedButton(
              onPressed: () {
                Get.to(const EditMenuPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF492803),
                fixedSize: const Size(250, 50),
              ),
              child: const Text(
                'Chỉnh sửa menu',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF492803), width: 2),
              ),
              child: const Text(
                  'Best Seller',
                  style: TextStyle(
                      color: Color(0xFF492803),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Second Family'
                  )
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: listProduct.map(
                        (product) => CardProductBestSeller(
                          product: product,
                          addProductToOrder:addProductToOrder,
                        )
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


