import 'package:flutter/material.dart';

class ButtonEditPage extends StatelessWidget {
  ButtonEditPage({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  IconData icon;
  final VoidCallback onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Container(
                child:  Row(
                  children: [
                    Icon(icon,color: const Color(0xFF492803),size:30),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        text,
                        style: const TextStyle(
                            color: Color(0xFF492803),
                            fontSize: 25,
                            fontFamily: 'Secondary Family',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,color: Color(0xFF492803),),
            ]
        ),
      ),
    );
  }
}