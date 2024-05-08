import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CountController extends StatefulWidget {
  @override
  _CountControllerState createState() => _CountControllerState();
}

class _CountControllerState extends State<CountController> {
  var _counter = 1.obs;

  void _incrementCounter() {
    _counter++;

  }

  void _decrementCounter() {

    _counter--;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 137,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: _decrementCounter,
            child: Text('-',style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(10, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero, // Remove padding
            ),
          ),
          Obx(
                ()=> Text(
                '$_counter',style: TextStyle(fontSize: 15)
            ),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('+', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero, // Remove padding
            ),
          ),
        ],
      ),
    );
  }
}