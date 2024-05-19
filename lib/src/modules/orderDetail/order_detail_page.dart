import 'package:flutter/material.dart';
import 'package:qlqn/src/firebase/product_firestore.dart';
import 'package:qlqn/src/models/category.dart';
import 'package:qlqn/src/models/product.dart';
import '../../models/orderDetail.dart';
import 'components/list_product.dart';

class OrderDeatilPage extends StatelessWidget {
  final Categories categories;
  List<OrderDetail> listProtuctOrder;
 OrderDeatilPage({super.key, required this.categories, required this.listProtuctOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: Text(
          categories.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            fontFamily: 'Lora',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: SafeArea(
        top: true,
        child: FutureBuilder<List<Product>>(
          future: ProductFireStore().getByCategoryId(categories.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Product> products = snapshot.data!;
              return ListProduct(products: products,listProtuctOrder: listProtuctOrder,);
            }
          },
        ),
      ),
    );
  }
}





