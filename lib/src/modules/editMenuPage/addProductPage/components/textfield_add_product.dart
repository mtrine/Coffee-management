import 'package:flutter/material.dart';
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
