import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/firebase/services/history_controller.dart';

class HistoryPage extends StatelessWidget {
  final List<String> scannedProducts;

  const HistoryPage({super.key, required this.scannedProducts});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History',style: GoogleFonts.lexend(),
        ),
        backgroundColor: const Color(0xfff4f2f2),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> products = snapshot.data ?? [];
            if (products.isEmpty) {
              return Center(
                child: Text('You haven\'t scanned anything yet',style: GoogleFonts.lexend(fontSize:20,color:Colors.black),),
              );
            }
            else {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30), // Add horizontal padding
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var product = products[index];
                    var score = int.tryParse(product['score']?.toString() ?? '0') ?? 0;
                    Color dotColor;
                    if (score >= 80) {
                      dotColor = Colors.green[900]!;
                    } else if (score >= 70) {
                      dotColor = Colors.green[400]!;
                    } else if (score >= 50) {
                      dotColor = Colors.yellow;
                    } else if (score >= 30) {
                      dotColor = Colors.orange;
                    } else {
                      dotColor = Colors.red;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: ()=> {
                          Get.to(()=> ProductDetailsPage(documentId: product['gtin']))
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff4f2f2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                            child: ListTile(
                              title: Text(
                                product['name'] ?? 'Unknown',
                                style: GoogleFonts.lexend(fontSize: 21, fontWeight: FontWeight.w400),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    score.toString(),
                                    style: GoogleFonts.lexend(color: Colors.black,fontSize:15),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: dotColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemCount: products.length,
                ),
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchProductDetails() async {
    List<Map<String, dynamic>> products = [];

    try {
      for (var gtin in scannedProducts) {
        var snapshot = await FirebaseFirestore.instance
            .collection('Consumables')
            .doc(gtin.trim())
            .get();

        if (snapshot.exists) {
          var data = {}.obs;
          data.value = snapshot.data() ?? {};
          products.add({
            'name': data['Name'],
            'score': data['Score'],
            //'manufacturerId': data['Manufacturer'], // Assuming this is the manufacturer ID
            'gtin' : gtin,
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    return products;
  }
}