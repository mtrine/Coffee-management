import 'dart:async';

import 'package:flutter/material.dart';
class TextFieldToAddStaff extends StatelessWidget {
  TextFieldToAddStaff({
    super.key,
    required this.content,
    required this.hintText,
    required this.controller,
    required this.isPassword,
    required this.streamController
  });
  TextEditingController controller ;
  String content;
  String hintText;
  bool isPassword ;
  Stream<String> streamController ;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamController,
      builder: (context, snapshot) {
        return Row(
          children: [
            Text(content, style: const TextStyle(color: Color(0xFF492803),fontSize: 20,fontWeight: FontWeight.w400)),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  errorText: snapshot.hasError?snapshot.error.toString():null,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hintText,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Bo góc
                      borderSide: const BorderSide(color:  Color(0xFF492803), width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Bo góc
                      borderSide: const BorderSide(color:  Color(0xFF492803), width: 2.0)
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Bo góc
                      borderSide: const BorderSide(color: Colors.red, width: 2.0)
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}