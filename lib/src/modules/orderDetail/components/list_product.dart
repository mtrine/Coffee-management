import 'package:flutter/material.dart';
import '../../../models/orderDetail.dart';
import '../../../models/product.dart';
import 'card_product.dart';

class ListProduct extends StatelessWidget {
   ListProduct({
    super.key,
    required this.products,
    required this.listProtuctOrder,
  });

  final List<Product> products;
   List<OrderDetail> listProtuctOrder ;
  @override
  Widget build(BuildContext context) {
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
          children: products.map((product) => CardProduct(product: product,listProtuctOrder: listProtuctOrder,)).toList(),
        ),
      ),
    );
  }
}