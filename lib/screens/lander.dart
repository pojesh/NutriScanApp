
// ignore_for_file: unnecessary_import, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled1/screens/historypage.dart';
import 'package:untitled1/screens/product_details.dart';
import 'package:untitled1/screens/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/firebase/services/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:untitled1/firebase/services/history_controller.dart';
import 'package:untitled1/firebase/services/user_history.dart';


class LanderClass extends StatelessWidget {
  final controller = Get.put(LoginController());
  final RxString barcodeResult = ''.obs;
  final List<String> scannedProducts = <String>[].obs;
  final firestoreService = FirestoreService();
  final RxInt historyCount = 0.obs;

  Future<void> scanBarcode() async {
    try {
      final String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeResult);

      if (barcodeResult.length >= 9) {
        final String gtin = barcodeResult.substring(3, 9);
        if (!scannedProducts.contains(gtin)) {
          scannedProducts.add(gtin);
        }
        firestoreService.addProductToHistory(
            controller.getUserId(),
            controller.googleAccount.value?.displayName??'Null',
            gtin
        );
        Get.to(() => ProductDetailsPage(documentId: gtin));
      }
      else {
        // Handle invalid barcode result
        debugPrint('Invalid barcode result');
      }
    } catch (e) {
      debugPrint('Error scanning barcode: $e');
    }
  }


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
    Get.put(UserHistory());
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
                child: GestureDetector(
                  onTap: () => scanBarcode(),
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
                            'Scanned ${scannedProducts.length}',
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
                          'Avoided 0',
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
                          'Alternatives 0',
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

                  child: GestureDetector(
                    onTap: () {
                      // Access the UserController instance
                      UserHistory userHistoryController = Get.find<UserHistory>();

                      // Call fetchUserHistory to get the user history list
                      userHistoryController.fetchUserHistory().then((userHistory) {
                        historyCount.value = userHistory.length;
                        // Navigate to the HistoryPage and pass the user history as scannedProducts
                        Get.to(() => HistoryPage(scannedProducts: userHistory));
                      });
                    },
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
                              'History ${historyCount}',
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
            )
          ],
        )
      ],
    );
  }
}