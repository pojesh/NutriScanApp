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
        title: Text('Scan History',style: GoogleFonts.lexend(),),
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
              return ListView.separated(
                itemBuilder: (context, index) {
                  var product = products[index];
                  var score = int.tryParse(
                      product['score']?.toString() ?? '0') ?? 0;
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
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductDetailsPage(documentId: product['gtin']));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Expanded(

                                  child: Text(
                                    product['name'] ?? 'Unknown',
                                    style: GoogleFonts.lexend(fontSize: 20,
                                        fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      score.toString(),
                                      style: GoogleFonts.lexend(
                                          color: Colors.black),
                                    ),
                                    SizedBox(width: 4),
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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 5,bottom:15),
                          child: Text(
                            'Manufacturer: ${product['manufacturerId'] ??
                                'Unknown'}',
                            style: GoogleFonts.lexend(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                itemCount: products.length,
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
            'manufacturerId': data['Manufacturer'], // Assuming this is the manufacturer ID
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