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
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(width: 10), // Add some spacing between title and content
          Expanded(
            flex: 3,
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
