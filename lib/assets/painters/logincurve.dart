import 'package:flutter/material.dart';

class LoginCurve extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 186, 225, 246)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;


    Path path_0 = Path();
    path_0.moveTo(size.width*0.0,size.height*0.0);
    path_0.lineTo(size.width*0.0,size.height*0.9066061);
    path_0.quadraticBezierTo(size.width*0.1982123,size.height*1.0232424,size.width*0.5,size.height*1.0266970);
    path_0.quadraticBezierTo(size.width*0.8417667,size.height*1.0208788,size.width*1.0,size.height*0.9066061);
    path_0.lineTo(size.width*1.0,size.height*0.0);

    canvas.drawPath(path_0, paint_fill_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

