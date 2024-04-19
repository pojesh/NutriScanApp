import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/profile.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {

  var userName = 'Tony Stark';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                          Get.to(Profile());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                            child: Image(
                                  image: AssetImage('lib/asset/images/gosling.png'),
                                  width: 44,
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
        ),
    );
  }
}
