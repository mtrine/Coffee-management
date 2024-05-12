import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/modules/editMenuPage/deletePage/delete_page.dart';
import 'package:qlqn/src/modules/editMenuPage/updateProductPage/update_product_page.dart';
import 'addProductPage/add_product_page.dart';
import 'components/button_edit_page.dart';
class EditMenuPage extends StatelessWidget {
  const EditMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Chỉnh sửa menu',
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
        child: ListView(
          children: [
            ButtonEditPage(
                icon:Icons.add_box,
                text:'Thêm món',
                onTap: ()=>Get.to(AddProductPage())
            ),
            ButtonEditPage(
                icon:Icons.border_color,
                text:'Chỉnh sửa',
                onTap: ()=>Get.to(UpdateProductPage())
            ),
            ButtonEditPage(
                icon:Icons.delete,
                text:'Xóa món',
                onTap: ()=>Get.to(DeletePage())
            ),
          ],
        ),
      ),
    );
  }
}


