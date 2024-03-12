import 'package:flutter/material.dart';
import 'package:untitled1/assets/painters/logincurve.dart';
import 'package:untitled1/assets/painters/circles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/assets/collorrs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:flutter/services.dart';

class LoginClass extends StatefulWidget {
  const LoginClass({Key? key}) : super(key: key);

  @override
  State<LoginClass> createState() => loginState();
}

class loginState extends State<LoginClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 330,
            width: 420,
            child: CustomPaint(
                size: Size(420,(420*0.8009708737864077).toDouble()),
                painter: LoginCurve(),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                            'NutriScan',
                            style: GoogleFonts.lato(
                              fontSize:55,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                            'For healthier living',
                            style: GoogleFonts.lato(
                              fontSize:25,
                              color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40.0,bottom: 30.0),
            child: Text(
              'Lets get started!',
              style: GoogleFonts.lato(
              fontSize:35,
              ),
            ),
          ),
          SizedBox(
            height:80,
            width:80,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.loginAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                ),
                child: const Icon(
                    Icons.arrow_forward,
                    size: 35,
                ),
              ),
              onTap: () {
                HapticFeedback.vibrate();

                Fluttertoast.showToast(
                  msg: "Sign-in with Google",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 100),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 200,
                width: 200,
                child: CustomPaint(
                  size: Size(200,(200*1).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: LoginCircles(),
                ),
              ),
            ),
          )
        ], // children
      ),
    );
  }
}
