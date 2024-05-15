import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qlqn/src/models/category.dart';
import 'package:qlqn/src/models/product.dart';
import '../../../firebase/category_firestore.dart';
import '../../../firebase/firebase_storage.dart';
import '../../../firebase/product_firestore.dart';
import 'components/textfield_add_product.dart';


class AddProductPage extends StatefulWidget {
   const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<Categories> categories = [];
  var dropDownValue=''.obs;
  String categoryId = '';
  XFile? image;
  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchCategories();
    dropDownValue.value="Chọn mục";
  }

  Future<void> _fetchCategories() async {
    List<Categories> fetchedCategories = await CategoryFireStore().getAllDocuments();
    setState(() {
      categories = fetchedCategories;
    });
  }

  Future<void> addProduct() async {
    try {
      String url = await StorageService().uploadFile(File(image!.path), 'upload');
      int unitPrice = int.parse(priceController.text);
      DocumentReference categoryRef = FirebaseFirestore.instance.collection('Category').doc(categoryId);
      Product product = Product("", nameController.text, unitPrice, url, categoryRef);
      await ProductFireStore().insert(product);

      // Hiển thị Snackbar thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Thêm sản phẩm thành công'),
        duration: Duration(seconds: 2), // Thời gian hiển thị Snackbar
      ));

      // Đặt lại trạng thái ban đầu
      setState(() {
        image = null;
        nameController.text = '';
        priceController.text = '';
        dropDownValue.value = 'Chọn mục';
      });
    } catch (error) {
      print('Error adding product: $error');
      // Hiển thị Snackbar thông báo thất bại
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Thêm sản phẩm thất bại'),
        duration: Duration(seconds: 2), // Thời gian hiển thị Snackbar
      ));
    }
  }

  void FdropDownValue(String? value) {
    if (value != null) {
        dropDownValue.value = value;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Thêm món',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async{
                        image = await StorageService().pickImage();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        fixedSize: const Size(200, 200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:  image != null
                          ? Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                          : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_sharp, color: Colors.grey, size: 60),
                            Text(
                              'Chọn ảnh',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                                fontFamily: 'Secondary Family',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
              ),
              TextFieldAddProduct(hintText: "Nhập tên món",controller: nameController,content: 'Tên món',),
              TextFieldAddProduct(hintText: "Nhập giá món",controller: priceController,content: 'Giá món',),
              Row(
                children: [
                  const Text(
                    "Mục",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
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
                            }),
                          ],
                          onChanged: (value) {
                            FdropDownValue(value);
                            var selectCategory= categories.firstWhere((element) => element.name == value);
                            categoryId = selectCategory.id;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                    onPressed: addProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF492803),
                      fixedSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Thêm món',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Secondary Family',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                ),
              )
            ],
          )
        ),
      )
    );
  }
}

