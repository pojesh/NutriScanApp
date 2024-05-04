import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:untitled1/screens/lander.dart';

class ProductDetails extends StatelessWidget {
  final String barcodeResult;
  ProductDetails(this.barcodeResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: buildProductDetails(),
      ),
    );
  }

  Center buildProductDetails() {
    return Center(
      child: Text(
        barcodeResult,
      ),
    );
  }
}
