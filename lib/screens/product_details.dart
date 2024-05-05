import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailsController extends GetxController {
  final String documentId;
  var data = {}.obs; // Observe the data changes
  var mat_data = {}.obs;

  ProductDetailsController({required this.documentId});

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Fetch data when controller is initialized
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
        data.value = snapshot.data() ?? {}; // Update data value with fetched data
        mat_data.value = materials_snapshot.data() ?? {};
      } else {
        data.value = {};
        mat_data.value={};
      }
    } catch (e) {
      // Handle error
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
    print('Document ID: $documentId');
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
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
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Image.network(
                        image_link, //URL with the URL of your image
                        fit: BoxFit.cover, // You can change BoxFit to the desired fit
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            );
                          }
                        },
                      ),
                    ),
                    Text(
                      'Product Name: $productName',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'UID: $documentId',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Manufacturer: $manufacturer',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Score: $score',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Ingredients:',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: materials.entries.map<Widget>((entry) {
                        String fieldName = entry.key;
                        String value = entry.value.toString();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Field Name: $fieldName',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Value: $value',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }
          });
        },
      ),
    );
  }
}
