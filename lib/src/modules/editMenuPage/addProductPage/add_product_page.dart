import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qlqn/src/models/category.dart';

import '../../../firebase/category_firestore.dart';


class AddProductPage extends StatefulWidget {
   AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<Categories> categories = [];
  String _dropDownValue='';
  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _dropDownValue="Chọn mục";
  }

  Future<void> _fetchCategories() async {
    List<Categories> fetchedCategories = await CategoryFireStore().getAllDocuments();
    setState(() {
      categories = fetchedCategories;
    });
  }

  void dropDownValue(String? value) {
    if (value != null) {
      setState(() {
        _dropDownValue = value;
      });
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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: ElevatedButton(
                      onPressed: (){
                        print(_dropDownValue);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        fixedSize: Size(200, 200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Icon(Icons.add_a_photo_sharp,color: Colors.grey,size:60),
                              Text(
                                'Chọn ảnh',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                    fontFamily: 'Secondary Family',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ]
                                      ),
                      )
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
                      child: DropdownButton<String>(
                        value: _dropDownValue.isNotEmpty ?  _dropDownValue : null,
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
                          dropDownValue(value);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      )
    );
  }
}

class TextFieldAddProduct extends StatelessWidget {
  TextFieldAddProduct({
    super.key,
    required this.hintText,
    required this.content,
    required this.controller
  });
  String hintText ;
  String content ;
  TextEditingController controller ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text(
            content,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold
            ),
          ),
         const SizedBox(width: 10), // Add this line
         Expanded(
           child: TextField(
             controller: controller,
             decoration: InputDecoration(
               filled: true,
               fillColor: Colors.white,
               hintText: hintText,
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
         )
        ],
      ),
    );
  }
}
