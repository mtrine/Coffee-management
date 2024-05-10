import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/models/orderDetail.dart';
import 'package:qlqn/src/models/product.dart';
import 'count_controller.dart';
class CardItemOder extends StatelessWidget {
  CardItemOder({
    super.key,
    required this.productOrder,
    required this.total,
    required this.handleDelete,
  });
  OrderDetail productOrder;
  var total;
  Function handleDelete;
  Future<Product> getInformation( ) async {
    try{
      DocumentSnapshot snapshot = await productOrder.productId!.get();
      Product product = Product(
        snapshot.id,
        snapshot['name'],
        snapshot['unitPrice'],
        snapshot['image_url'],
        snapshot['categoryId'],
      );
      return product;
    }catch(e){
      print(e);
      throw e; // Ném lại lỗi để có thể xử lý ngoại lệ ở nơi gọi hàm này
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: getInformation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Có lỗi xảy ra'),
          );
        }
        Product product = snapshot.data!;
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
                            IconButton(
                                icon: const Icon(Icons.delete_forever, size: 50),
                                onPressed: () {
                                  handleDelete(productOrder.productId);
                                },
                            ),
                            CountController(productOrder: productOrder,),
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
      },
    );
  }
}