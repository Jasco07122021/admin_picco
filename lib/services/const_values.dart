import 'package:flutter/material.dart';

Color pageColor = const Color.fromRGBO(254, 249, 249, 1);
Color mainColor = const Color.fromRGBO(71, 9, 246, 1);

double heightMax(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double widthMax(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
