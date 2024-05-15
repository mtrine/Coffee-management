import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qlqn/src/models/category.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    super.key,
    required this.category,
  });

  final Categories category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              category.imageUrl, // Sử dụng URL của hình ảnh từ Firebase Storage
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5), // Khoảng cách giữa hình ảnh và văn bản
          SizedBox(
            width: 100, // Độ rộng tối đa của văn bản
            child: Text(
              category.name, // Sử dụng tên danh mục từ đối tượng Category
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Itim',
                fontWeight: FontWeight.w600,
                color: Color(0xFF492803),
              ),
              maxLines: 2, // Số dòng tối đa
              overflow: TextOverflow.ellipsis, // Hiển thị dấu chấm (...) khi văn bản vượt quá
              textAlign: TextAlign.center, // Căn giữa văn bản
            ),
          ),
        ],
      ),
    );
  }
}
