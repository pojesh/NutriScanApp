import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0,h);
    path.quadraticBezierTo(
      w * 0.5,
      h + 100,
      w,
      h,
    );
    path.lineTo(w,0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}