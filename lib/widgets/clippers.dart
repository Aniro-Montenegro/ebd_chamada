


import 'package:flutter/cupertino.dart';

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height-55);
    var controllPoint=Offset(25, size.height);
    var endPoint =Offset(size.width/2, size.height);

    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height-15);
    path.lineTo(size.width, 0);



    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
  
  
}