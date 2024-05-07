import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/staff.dart';
import '../../../dialog/loading_dialog.dart';
import '../../../dialog/msg_dialog.dart';
import '../../../my_app.dart';
import '../../homePage/home_page.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}


class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    void _onSignInClick() async {
      final String phone = _phoneController.text;
      final String password = _passwordController.text;
      final Staff? staff = await Staff.getByPhone(phone); // Sử dụng phương thức getByPhone
      var authBloc = MyApp.of(context).authBloc;
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      if (staff != null) {
        authBloc.signIn(phone, password, () {
          LoadingDialog.hideLoadingDialog(context);
          Get.to(() => HomePage(staff: staff));
        }, (msg) {
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, 'Sign-In', msg);
        });
      } else {
        LoadingDialog.hideLoadingDialog(context);
        print('Don\'t have staff');
      }
    }
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nhập số điện thoại',
                  prefixIcon: const Icon(
                    Icons.account_box,
                    color: Color(0xFF492803),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF492803), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF492803), width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordObscured,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nhập mật khẩu',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured=!_isPasswordObscured;
                        });
                      },
                      icon: Icon(
                        _isPasswordObscured ?Icons.visibility  :Icons.visibility_off ,
                        color: Color(0xFF492803),
                      ),
                    ),
                    prefixIcon: Icon(Icons.key, color: Color(0xFF492803)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF492803), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF492803), width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _onSignInClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF492803),
                  fixedSize: const Size(250, 50),
                ),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      
    );
  }
}
