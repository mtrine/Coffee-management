import 'package:flutter/material.dart';
import 'package:qlqn/src/models/product.dart';

import 'count_controller.dart';
class CardItemOder extends StatelessWidget {
   CardItemOder({
    super.key,
    required this.product,

  });
  Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffc49a6c),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: product.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Primary Family',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '\n${product.unitPrice}đ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                              fontFamily: 'Primary Family',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.delete_forever, size: 50),
                        CountController(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}