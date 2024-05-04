import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart'; // Import GetX

class DetailsController extends GetxController {
  final String documentId;
  var data = {}.obs; // Observe the data changes

  DetailsController({required this.documentId});

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Fetch data when controller is initialized
  }

  Future<void> fetchData() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('Consumables').doc(documentId).get();
      if (snapshot.exists) {
        data.value = snapshot.data() ?? {}; // Update data value with fetched data
      } else {
        // Handle case when document doesn't exist
        data.value = {};
      }
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }
}

class ProductDetails extends StatelessWidget {
  final String documentId;
  final DetailsController controller;

  ProductDetails(this.documentId) : controller = Get.put(DetailsController(documentId: documentId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumable Details'),
      ),
      body: Obx(() {
        if (controller.data.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: [
              ListTile(
                title: Text('Name: ${controller.data['Name']}'),
              ),
              ListTile(
                title: Text('Image: ${controller.data['Image']}'),
              ),
              ListTile(
                title: Text('Score: ${controller.data['Score']}'),
              ),
              // Add more ListTile widgets for other fields if needed
            ],
          );
        }
      }),
    );
  }
}
