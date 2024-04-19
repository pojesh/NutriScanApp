import 'package:flutter/material.dart';
import 'package:untitled1/screens/home.dart';
import 'package:untitled1/screens/login.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xffff4f2f2)
      ),
      home: const Home(),
    );
  }
}
