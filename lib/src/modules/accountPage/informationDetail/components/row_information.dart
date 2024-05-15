import 'package:flutter/material.dart';

class RowInformation extends StatelessWidget {
  final String title;
  final String content;

  const RowInformation({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}