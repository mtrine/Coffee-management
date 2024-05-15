import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  TextRow({
    super.key,
    required this.title,
    required this.content,
  });
  String title;
  String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20,10, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text(
              title,
              style: const TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto'
              ),
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Secondary Family',
              ),
            ),
          ]
      ),
    );
  }
}