import 'package:flutter/material.dart';
import 'package:untitled1/screens/lander.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBnzH6xSeY_33EJ-DPtqH4I44A85_MCsB0',
        appId: '1:89907047171:android:ead4d836520b1006785736',
        messagingSenderId: '89907047171',
        projectId: 'nutriscan-69420',
        storageBucket: 'nutriscan-69420.appspot.com',
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xfff4f2f2)
      ),
      home: LanderClass(),
    );
  }
}