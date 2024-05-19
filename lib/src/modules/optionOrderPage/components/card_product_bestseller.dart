import 'package:flutter/material.dart';

import '../../../models/product.dart';

class CardProductBestSeller extends StatelessWidget {
  CardProductBestSeller({
    super.key,
    required this.product,
    required this.addProductToOrder,
  });
  Product product;
  Function addProductToOrder;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    product.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${product.unitPrice} VND',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                style: IconButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                onPressed: () {
                  addProductToOrder(product);
                },
                icon: const Icon(Icons.add, color: Colors.black, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}