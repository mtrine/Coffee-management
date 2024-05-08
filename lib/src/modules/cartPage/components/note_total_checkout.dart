import 'package:flutter/material.dart';
class NoteTotalCheckOut extends StatelessWidget {
  NoteTotalCheckOut({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              hintText: 'Ghi chú...',
              hintStyle:  TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontFamily: 'Primary Family',
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền: ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Secondary Family',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '100000',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Secondary Family',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){},
              child: Text(
                  'Thanh toán',
                  style: TextStyle(
                      color:Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Secondary Family'
                  )
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF492803),
                fixedSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )
          )
        ],
      ),
    );
  }
}