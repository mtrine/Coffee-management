import 'package:flutter/material.dart';
import 'package:qlqn/src/modules/logInAndSignUpPage/logInPage/login_page.dart';
import 'package:qlqn/src/modules/logInAndSignUpPage/signUpPage/signUpPage.dart';

class LogInAndSignUpPage extends StatelessWidget {
  const LogInAndSignUpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600), // Đặt kích thước chữ
                ),
              ),
              Tab(
                child: Text(
                  'Đăng ký',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600), // Đặt kích thước chữ
                ),
              ),
            ],
            indicatorWeight: 4.0, // Đặt chiều cao của thanh bên dưới
            indicatorSize: TabBarIndicatorSize.tab, // Thanh bên dưới của tab sẽ có chiều dài full
            indicatorPadding: EdgeInsets.zero,
            indicatorColor: Color(0xFF492803), // Màu của thanh bên dưới
            labelColor: Color(0xFF492803), // Màu chữ của tab đã chọn
            unselectedLabelColor: Color(0xFF57636c), // Màu chữ của tab chưa chọn
          ),
        ),
        body: TabBarView(
          children: [
            LogInPage(),
            SignUpPage(),
          ],
        ),
      ),
    );
  }
}

