import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_nest/screens/auth/sign-in/login_screen.dart';
import 'package:urban_nest/screens/sampleScreen.dart';
import 'package:urban_nest/test_login_screen.dart';
import 'package:urban_nest/test_phone_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginScreen()
    );
  }
}

