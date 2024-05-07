import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qlqn/src/firebase/product_firestore.dart';
import 'package:qlqn/src/models/category.dart';
import 'package:qlqn/src/models/product.dart';

import 'components/card_product.dart';

class OrderDeatilPage extends StatelessWidget {
  final Categories categories;

  const OrderDeatilPage({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: Text(
          categories.name,
          style: const TextStyle(
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
        top: true,
        child: FutureBuilder<List<Product>>(
          future: ProductFireStore().getByCategoryId(categories.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Product> products = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:  GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    scrollDirection: Axis.vertical,
                    children: products.map((product) => CardProduct(product: product)).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}



