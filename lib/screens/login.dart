// ignore_for_file: unnecessary_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/asset/painters/logincurve.dart';
import 'package:untitled1/asset/painters/circles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/asset/collorrs.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/firebase/services/signin.dart';
import 'package:untitled1/screens/home.dart';

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
                    image: AssetImage('lib/asset/images/nutriscanlogopng.png'),
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
                padding: const EdgeInsets.only(top: 75,bottom: 30),

                  child: SizedBox(
                    width: 275,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: 'Login Successful',
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:28,right:10),
                                  child: Image(
                                    image: AssetImage('lib/asset/images/google.png'),
                                    width: 33,
                                  ),
                                ),
                                Text(
                                  'Continue with Google',
                                  style: GoogleFonts.lexend(
                                    fontSize: 17,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                )
                              ],
                            )
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: 210,
                child: Text(
                  'By clicking “Continue with Google”, you agree to our ToS and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                    fontSize: 10,
                    color: Colors.black.withOpacity(0.6),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    )
                  )
                ),
              )
            ], // children
          ),
      ),
    );
  }
}
