// ignore_for_file: unnecessary_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled1/screens/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/firebase/services/login_controller.dart';
import 'package:get/get.dart';

class LanderClass extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.googleAccount.value != null) {
            return buildHomePage();
          } else {
            return buildLogin();
          }
        }),
      ),
    );
  }

  Column buildLogin() {
    return Column(
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
                  width: 276,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      /*Fluttertoast.showToast(
                        msg: 'Login Successful',
                      );*/
                      controller.login();
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
                                padding: const EdgeInsets.only(left:12,right:10),
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
        );
  }

  Column buildHomePage() {
    var userName = controller.googleAccount.value?.displayName ?? ' ';
    return Column(
      children: [
        Container (
          child: Padding(
            padding: const EdgeInsets.only(top: 69,left:23,right:23,bottom: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello 👋🏻\n' + userName,
                  style: GoogleFonts.lexend(
                    fontSize:22,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => Profile());
                  },
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: CircleAvatar(
                      backgroundImage: Image.network(controller.googleAccount.value?.photoUrl ?? '',fit: BoxFit.cover,).image,
                      radius: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Text(
                'Your Insights',
                style: GoogleFonts.lexend(
                  fontSize:19,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10,top:40),
              child: SizedBox(
                height: 178,
                width: 160,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:30,bottom:10),
                        child: Image(
                          image: AssetImage('lib/asset/images/scan.png'),
                          width: 55,
                        ),
                      ),
                      Text(
                          'Scan new',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                          )
                      ),
                      Text(
                          'Scanned 483',
                          style: GoogleFonts.lexend(
                              fontSize: 13,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w300
                              )
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:10,top:40),
              child: SizedBox(
                height: 178,
                width: 160,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:30,bottom:10),
                        child: Image(
                          image: AssetImage('lib/asset/images/avoid.png'),
                          width: 55,
                        ),
                      ),
                      Text(
                          'Products to Avoid',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                          )
                      ),
                      Text(
                          'Avoided 32',
                          style: GoogleFonts.lexend(
                              fontSize: 13,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w300
                              )
                          )
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10,top:60),
              child: SizedBox(
                height: 178,
                width: 160,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:30,bottom:10),
                        child: Image(
                          image: AssetImage('lib/asset/images/alternatives.png'),
                          width: 55,
                        ),
                      ),
                      Text(
                          'Healthy Alternatives',
                          style: GoogleFonts.lexend(
                            fontSize: 13,
                          )
                      ),
                      Text(
                          'Alternatives 8',
                          style: GoogleFonts.lexend(
                              fontSize: 13,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w300
                              )
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:10,top:60),
              child: SizedBox(
                height: 178,
                width: 160,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:30,bottom:10),
                        child: Image(
                          image: AssetImage('lib/asset/images/history.png'),
                          width: 55,
                        ),
                      ),
                      Text(
                          'History',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                          )
                      ),
                      Text(
                          'History 26',
                          style: GoogleFonts.lexend(
                              fontSize: 13,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w300
                              )
                          )
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

