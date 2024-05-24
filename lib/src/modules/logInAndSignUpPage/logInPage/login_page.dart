import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlqn/src/models/orderDetail.dart';
import 'package:qlqn/src/models/staff.dart';
import '../../../dialog/loading_dialog.dart';
import '../../../dialog/msg_dialog.dart';
import '../../../my_app.dart';
import '../../homePage/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});
  List<OrderDetail> listProtuctOrder =[];
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isRememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMeStatus();
  }

  _loadRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isRememberMe = prefs.getBool('rememberMe') ?? false;
      if (_isRememberMe) {
        _phoneController.text = prefs.getString('phone') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  _saveRememberMeStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
    if (!value) {
      await prefs.remove('phone');
      await prefs.remove('password');
    } else {
      await prefs.setString('phone', _phoneController.text);
      await prefs.setString('password', _passwordController.text);
    }
  }

  void onSignInClick() async {
    final String phone = _phoneController.text;
    final String password = _passwordController.text;
    final Staff? staff = await Staff.getByPhone(phone); // Sử dụng phương thức getByPhone
    var authBloc = MyApp.of(context).authBloc;
    LoadingDialog.showLoadingDialog(context, 'Loading...');
    if (staff != null) {
      authBloc.signIn(phone, password, () {
        LoadingDialog.hideLoadingDialog(context);
        _saveRememberMeStatus(_isRememberMe);
        Get.to(() => HomePage(staff: staff,listProtuctOrder:widget.listProtuctOrder ,));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Đăng nhập', msg);
      });
    } else {
      LoadingDialog.hideLoadingDialog(context);
      print('Don\'t have staff');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                  image: AssetImage('assets/img/Logo.jpg'), height: 300, width: 300),
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
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                    icon: Icon(
                      _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF492803),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.key, color: Color(0xFF492803)),
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
              Row(
                children: [
                  Checkbox(
                    fillColor: MaterialStateProperty.all(const Color(0xFF492803)),
                    checkColor: Colors.white,
                    value: _isRememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _isRememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    "Remember me",
                    style: TextStyle(
                      fontSize:16,
                      color: Color(0xFF492803),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onSignInClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF492803),
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
      ),
    );
  }
}
