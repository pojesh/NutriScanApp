// ignore_for_file: unnecessary_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled1/asset/painters/logincurve.dart';
import 'package:untitled1/asset/painters/circles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/asset/collorrs.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/firebase/services/signin.dart';

class LoginClass extends StatefulWidget {
  const LoginClass({Key? key}) : super(key: key);

  @override
  State<LoginClass> createState() => loginState();
}

// ignore: camel_case_types
class loginState extends State<LoginClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:175,bottom:25),
                child: Image(
                    image: AssetImage('lib/asset/images/nutriscanlogo.png'),
                    width: 60,
                ),
              ),
              Text(
                'NutriScan',
                style: GoogleFonts.lexend(
                  fontSize:35,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ), //style
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),

                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          Image(
                            image: AssetImage('lib/asset/images/google.png'),
                            width: 50,
                          )
                    ),
                  ),
                ),

            ], // children
          ),
      ),
    );
  }
}
