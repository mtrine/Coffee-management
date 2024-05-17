import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/models/product.dart';

import '../../../models/orderDetail.dart';

class CardProduct extends StatefulWidget {
  CardProduct({
    super.key,
    required this.product,
    required this.listProtuctOrder,
  });
  Product product;
  List<OrderDetail> listProtuctOrder;

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  void addProductToOrder(){
    try {
      // Create a DocumentReference for the product
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('Product').doc(widget.product.id);

      // Check if the product is already in the list
      bool productExists = widget.listProtuctOrder.any((orderDetail) {
        return orderDetail.productId == documentReference;
      });

      // If the product is not in the list, add it
      if (!productExists) {
        OrderDetail orderDetail = OrderDetail(
            "", null, documentReference, 1
        );
        widget.listProtuctOrder.add(orderDetail);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.product.name} đã thêm vào giỏ hàng'))
        );
      } else {
        // If the product is already in the list, show a notification
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('${widget.product.name} đã có trong giỏ hàng'),
                backgroundColor: Colors.red
            )
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF492803),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                widget.product.imageUrl,
                width: 150,
                height: 99,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 200,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFF492803),
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Color(0xFF492803),
                  width: 2,
                ),
              ),
            ),
            child: Text(
              widget.product.unitPrice.toString() ,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF492803),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  widget.product.name,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Color(0xFF492803),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF492803),
                  fixedSize: const Size(30, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: addProductToOrder,
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),

            ],
          ),
        ],
      ),

    );
  }
}