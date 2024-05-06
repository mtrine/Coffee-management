import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF492803),
        title: Text('Welcome.',
          style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontFamily: 'Lora',),
        ),
          automaticallyImplyLeading: false
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:[

              Container(
                padding: EdgeInsets.all(8.0), // Thiết lập padding cho khoảng cách giữa các nút
                child: GridView.count(
                  crossAxisCount: 2, // Số lượng cột trong GridView
                  crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                  mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFc49a6c),
                        fixedSize: Size(100, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        side: BorderSide(width: 2, color: Color(0xFF492803)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_note, size: 70.0, color: Colors.white),
                          SizedBox(height: 8.0),
                          Text('Order', style: TextStyle(fontSize: 20.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    //Thêm các ElevatedButton khác tương tự ở đây nếu cần
                  ],
                ),
              ),


            ],
              )

        )
      ) ,
    );
  }
}
