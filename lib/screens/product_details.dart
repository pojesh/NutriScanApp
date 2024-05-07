import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsController extends GetxController {
  final String documentId;
  var data = {}.obs;
  var mat_data = {}.obs;

  ProductDetailsController({required this.documentId});

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Consumables')
          .doc(documentId.trim()).get();
      var materials_snapshot = await FirebaseFirestore.instance
          .collection('Consumables')
          .doc(documentId.trim())
          .collection('Ingredients')
          .doc('materials')
          .get();

      if (snapshot.exists) {
        data.value = snapshot.data() ?? {};
        mat_data.value = materials_snapshot.data() ?? {};
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Cosmetics')
            .doc(documentId.trim()).get();
        materials_snapshot = await FirebaseFirestore.instance
            .collection('Cosmetics')
            .doc(documentId.trim())
            .collection('Ingredients')
            .doc('materials')
            .get();
        if (snapshot.exists) {
          data.value = snapshot.data() ?? {};
          mat_data.value = materials_snapshot.data() ?? {};
        } else {
          data.value = {};
          mat_data.value = {};
          Get.back();
          Fluttertoast.showToast(
            msg: "Product details does not exist",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey.withOpacity(0.8),
            textColor: Colors.black,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      Fluttertoast.showToast(
        msg: "Error fetching data $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

class ProductDetailsPage extends StatelessWidget {
  final String documentId;

  ProductDetailsPage({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: const Color(0xfff4f2f2),
      ),
      body: GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(documentId: documentId),
        builder: (controller) {
          return Obx(() {
            var image_link = controller.data['Image'];
            var productName = controller.data['Name'] ?? 'N/A';
            var manufacturer = controller.data['Manufacturer'] ?? 'N/A';
            var score = controller.data['Score'] ?? 'N/A';
            var materials = controller.mat_data;

            if (productName == 'N/A') {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left:35,bottom:15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image_link,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          Expanded( // Use Expanded instead of Flexible
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$productName",
                                  style: GoogleFonts.lexend(
                                    fontSize: 24,
                                    height:1.15,
                                  ),
                                ),
                                SizedBox(height:5),
                                Text(
                                  manufacturer,
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height:10),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _getDotColor(score),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width:10),
                                    Text(
                                      "$score/100",
                                      style: GoogleFonts.lexend(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1, // Adjust the height to make the line thicker
                      width: 370,
                      color: Colors.black, // Adjust the color of the line as needed
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,top:20,bottom:10),
                      child: Align(
                        alignment : Alignment.centerLeft,
                        child: Text(
                          'Ingredients',
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: materials.entries.map<Widget>((entry) {
                        String fieldName = entry.key;
                        String value = entry.value.toString();
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 45,right:45),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    fieldName,
                                    style: GoogleFonts.lexend(
                                      fontSize: 16,
                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.only(left:50),
                                    child: Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              value,
                                              style: GoogleFonts.lexend(fontSize:14),
                                            ),
                                            SizedBox(width:10),
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: _getDotColor(int.parse(value)),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height:24),
                            Container(
                              height:1,
                              width: 370,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 24),
                          ],
                        );
                      }).toList(),
                    ),
                  ]
              );
            }
          });
        },
      ),
    );
  }

  Color _getDotColor(int score) {
    int scoreValue = score ?? 0;
    if (scoreValue >= 80) {
      return Colors.green;
    } else if (scoreValue >= 70) {
      return Colors.lightGreen;
    } else if (scoreValue >= 50) {
      return Colors.yellow;
    } else if (scoreValue >= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
