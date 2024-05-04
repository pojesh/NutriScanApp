import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: buildProductDetails(), // Added semicolon here
      ),
    );
  }

  Center buildProductDetails() {
    return Center(
      child: Text(
        'hello',
      ),
    );
  }
}
