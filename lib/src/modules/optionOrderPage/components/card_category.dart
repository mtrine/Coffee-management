import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/models/category.dart';

class CardCategory extends StatelessWidget {
  CardCategory({
    Key? key,
    required this.category,
  }) : super(key: key);

  Categories category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            category.imageUrl, // Sử dụng URL của hình ảnh từ Firebase Storage
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          category.name, // Sử dụng tên danh mục từ đối tượng Category
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Itim',
            fontWeight: FontWeight.w600,
            color: Color(0xFF492803),
          ),
        ),
      ],
    );
  }
}
