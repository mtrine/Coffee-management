import 'package:flutter/material.dart';
import 'package:qlqn/src/firebase/firebase_storage.dart';
import '../../../firebase/product_firestore.dart';
import '../../../models/product.dart';
import '../components/card_product_edit.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    _fecthData();
  }
  void _fecthData() async {
      ProductFireStore productFireStore = ProductFireStore();
      List<Product> products = await productFireStore.getAllDocuments();
      setState(() {
        this.products = products;
      });
  }
  void deleteProduct(Product product) async {
    ProductFireStore productFireStore = ProductFireStore();
    await productFireStore.delete(product.id);
    await StorageService().deleteFile(product.imageUrl);
    _fecthData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Xóa món',
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
      body:SafeArea(
        child:SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.all(20.0),
            child:  GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              scrollDirection: Axis.vertical,
              children: products.map((product) =>  CardProductEdit(isDelete: true,product:product,deleteProduct:deleteProduct)).toList(),
            ),
          ),
        )
      )
    );
  }
}
