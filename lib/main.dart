import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/bloc/auth_bloc.dart';
import 'package:qlqn/src/modules/logInAndSignUpPage/login_and_signup.dart';
import 'package:qlqn/src/my_app.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
      AuthBloc(),
      const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogInAndSignUpPage(),
      )));
}
