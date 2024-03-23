import 'package:flutter/material.dart';
import 'package:untitled1/screens/scanner.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Text(
            'line of text',
          ),
        ],
      ),
    ));
  }
}
