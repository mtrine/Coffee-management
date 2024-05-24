import 'package:flutter/material.dart';
import 'package:qlqn/src/modules/logInAndSignUpPage/logInPage/login_page.dart';


class LogInAndSignUpPage extends StatelessWidget {
  const LogInAndSignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f0e3),
      body: LogInPage(),
    );
  }
}

