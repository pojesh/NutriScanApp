import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/firebase/services/history_controller.dart';
import 'package:untitled1/screens/product_details.dart';

class HistoryPage extends StatefulWidget {
  final List<String> scannedProducts;

  const HistoryPage({Key? key, required this.scannedProducts}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool showConsumables = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showConsumables = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: showConsumables ? Colors.white : Colors.black,
                  backgroundColor: showConsumables ? Colors.black : Colors.white,
                  side: BorderSide(color: Colors.black), // Add black border
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding
                ),
                child: Text(
                  'Consumables',
                  style: GoogleFonts.lexend(),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showConsumables = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: !showConsumables ? Colors.white : Colors.black,
                  backgroundColor: !showConsumables ? Colors.black : Colors.white,
                  side: BorderSide(color: Colors.black), // Add black border
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding
                ),
                child: Text(
                  'Cosmetics',
                  style: GoogleFonts.lexend(),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0), // Add padding below buttons
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
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
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      var score = product['score'];
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
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 22),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ProductDetailsPage(documentId: product['gtin']));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff4f2f2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(
                                  product['name'],
                                  style: GoogleFonts.lexend(fontSize: 20),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '$score',
                                      style: GoogleFonts.lexend(fontSize: 18, color: Colors.black),
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
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchProductDetails() async {
    List<Map<String, dynamic>> products = [];

    try {
      String collection = showConsumables ? 'Consumables' : 'Cosmetics';
      for (var gtin in widget.scannedProducts) {
        var snapshot = await FirebaseFirestore.instance
            .collection(collection)
            .doc(gtin.trim())
            .get();

        if (snapshot.exists) {
          var data = {}.obs;
          data.value = snapshot.data() ?? {};
          products.add({
            'name': data['Name'],
            'score': data['Score'],
            'manufacturerId': data['Manufacturer'], // Assuming this is the manufacturer ID
            'gtin': gtin
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }

    return products;
  }
}