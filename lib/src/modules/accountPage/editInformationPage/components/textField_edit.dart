import 'package:flutter/material.dart';

class TextFieldEdit extends StatelessWidget {
  final TextEditingController controller;
  final String content;
  final String hintText;

  const TextFieldEdit({
    Key? key,
    required this.content,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          content,
          style: const TextStyle(
            color: Color(0xFF492803),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF492803),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF492803),
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
