import 'package:flutter/material.dart';

class LoginCircles extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 186, 225, 246)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;


    Path path_0 = Path();
    path_0.moveTo(size.width*0.3068500,size.height*0.0942000);
    path_0.cubicTo(size.width*0.4068500,size.height*0.0942000,size.width*0.5568500,size.height*0.1642000,size.width*0.5568500,size.height*0.3442000);
    path_0.cubicTo(size.width*0.5568500,size.height*0.4442000,size.width*0.4818500,size.height*0.5942000,size.width*0.3068500,size.height*0.5942000);
    path_0.cubicTo(size.width*0.2068500,size.height*0.5942000,size.width*0.0568500,size.height*0.5192000,size.width*0.0568500,size.height*0.3442000);
    path_0.cubicTo(size.width*0.0568500,size.height*0.2442000,size.width*0.1318500,size.height*0.0942000,size.width*0.3068500,size.height*0.0942000);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(255, 186, 225, 246)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;


    Path path_1 = Path();
    path_1.moveTo(size.width*0.5547000,size.height*0.5797000);
    path_1.cubicTo(size.width*0.5992500,size.height*0.5797000,size.width*0.6660000,size.height*0.6108500,size.width*0.6660000,size.height*0.6909500);
    path_1.cubicTo(size.width*0.6660000,size.height*0.7354500,size.width*0.6326000,size.height*0.8022000,size.width*0.5547000,size.height*0.8022000);
    path_1.cubicTo(size.width*0.5102500,size.height*0.8022000,size.width*0.4435000,size.height*0.7688500,size.width*0.4435000,size.height*0.6909500);
    path_1.cubicTo(size.width*0.4435000,size.height*0.6465000,size.width*0.4768500,size.height*0.5797000,size.width*0.5547000,size.height*0.5797000);
    path_1.close();

    canvas.drawPath(path_1, paint_fill_1);

    // Circle

    Paint paint_fill_2 = Paint()
      ..color = const Color.fromARGB(255, 186, 225, 246)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;


    Path path_2 = Path();
    path_2.moveTo(size.width*0.7506232,size.height*0.1383789);
    path_2.cubicTo(size.width*0.7855828,size.height*0.1383789,size.width*0.8379633,size.height*0.1628232,size.width*0.8379633,size.height*0.2256798);
    path_2.cubicTo(size.width*0.8379633,size.height*0.2606001,size.width*0.8117535,size.height*0.3129807,size.width*0.7506232,size.height*0.3129807);
    path_2.cubicTo(size.width*0.7157421,size.height*0.3129807,size.width*0.6633616,size.height*0.2868100,size.width*0.6633616,size.height*0.2256798);
    path_2.cubicTo(size.width*0.6633616,size.height*0.1907987,size.width*0.6895322,size.height*0.1383789,size.width*0.7506232,size.height*0.1383789);
    path_2.close();

    canvas.drawPath(path_2, paint_fill_2);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
