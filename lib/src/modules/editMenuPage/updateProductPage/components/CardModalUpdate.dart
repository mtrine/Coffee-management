import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qlqn/src/models/product.dart';
import 'dart:io';
import '../../../../firebase/category_firestore.dart';
import '../../../../firebase/firebase_storage.dart';
import '../../../../firebase/product_firestore.dart';
import '../../../../models/category.dart';
class CardModelUpdate extends StatefulWidget {
  CardModelUpdate({super.key,required this.product});
  Product product;

  @override
  State<CardModelUpdate> createState() => _CardModelUpdateState();
}

class _CardModelUpdateState extends State<CardModelUpdate> {
  late TextEditingController _nameController ;
  late TextEditingController _priceController;
  var dropDownValue=''.obs;
  String categoryId = '';
  XFile? image;
  List<Categories> categories = [];
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.unitPrice.toString());
    _fetchCategories();

  }
  Future<void> _fetchCategories() async {
    List<Categories> fetchedCategories = await CategoryFireStore().getAllDocuments();
    String name = await CategoryFireStore().getName(widget.product.categoryId);
    categoryId = await CategoryFireStore().getId(widget.product.categoryId);
    setState(() {
      categories = fetchedCategories;
      dropDownValue.value = name;
    });
  }

  void FdropDownValue(String? value) {
    if (value != null) {
      dropDownValue.value = value;
    }
  }
  Future<void> updateProduct() async{
    try {
      late String url;
      if(image != null){
        url = await StorageService().uploadFile(File(image!.path), 'upload');
        await StorageService().deleteFile(widget.product.imageUrl);
      }
      else{
        url= widget.product.imageUrl;
      }
      int unitPrice = int.parse(_priceController.text);
      DocumentReference categoryRef = FirebaseFirestore.instance.collection('Category').doc(categoryId);
      Product product = Product(widget.product.id, _nameController.text, unitPrice, url, categoryRef);
      await ProductFireStore().update(product);
      Get.back();

    } catch (error) {
      print('Error adding product: $error');
      // Hiển thị Snackbar thông báo thất bạ
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              image != null
                  ? Image.file(
                File(image!.path),
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              )
                  : Image.network(
                widget.product.imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 20,),
              ElevatedButton(
                  onPressed: () async {
                    image = await StorageService().pickImage();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                  child: const Text(
                    'Chọn ảnh',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Secondary Family'
                    ),
                  )
              )
            ],
          ),
          const SizedBox(height: 20,),
          TextField(
            controller:_nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Tên món',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bo góc
                  borderSide: const BorderSide(color:  Color(0xFF492803), width: 2.0)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Bo góc
                  borderSide: const BorderSide(color:  Color(0xFF492803), width: 2.0)
              ),
            ),
          ),
          const SizedBox(height: 20,),
          TextField(
            controller:_priceController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Giá món',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bo góc
                  borderSide: const BorderSide(color:  Color(0xFF492803), width: 2.0)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Bo góc
                  borderSide: const BorderSide(color:  Color(0xFF492803), width: 2.0)
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF492803),
                width: 2,
              ),
            ),
            child: Obx(
                  ()=>DropdownButton<String>(
                value: dropDownValue.value.isNotEmpty ?  dropDownValue.value : null,
                isExpanded: true,
                items: [
                  const DropdownMenuItem<String>(
                    value: "Chọn mục",
                    child: Text("Chọn mục"),
                  ),
                  ...categories.map((Categories category) {
                    return DropdownMenuItem<String>(
                      value: category.name,
                      child: Text(category.name),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  FdropDownValue(value);
                  var selectCategory= categories.firstWhere((element) => element.name == value);
                  categoryId = selectCategory.id;
                },
              ),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: updateProduct,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4b39ef),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              child: const Text('Chỉnh sửa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
